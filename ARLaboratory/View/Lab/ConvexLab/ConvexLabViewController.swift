//
//  ConvexLabViewController.swift
//  ARPlayground
//
//  Created by 陈俊杰 on 10/29/20.
//

import UIKit
import SwiftUI
import ARKit
import RealityKit
import MultipeerConnectivity
import Combine
import Lottie

struct ConvexLabViewControllerContainer: UIViewControllerRepresentable {
    var leftAction: () -> Void
    
    func makeUIViewController(context: Context) -> ConvexLabViewController {
        let convexLabViewController = ConvexLabViewController(
            serviceType: "convex-lab", leftAction: leftAction)

        return convexLabViewController
    }

    func updateUIViewController(_ uiViewController: ConvexLabViewController, context: Context) {

    }
}

class ConvexLabViewController: ARLabViewController {
    
    
    // MARK: - Views
    var leftButtonView: UIView!
    var collaborationButtonView: UIView!
    var statisticButtonView: UIView!
    var commonSettingButtonView: UIView?
    var collaborationSettingView: UIView!
    var statisticView: UIView!
    var commonSettingView: UIView?
    var hintMessageLabelView: UIView!
    var confirmButtonView: UIView?
    var addRecordButtonView: UIView?
    var objectDistanceLabelView: UIView?
    var virtualImageDistanceLabelView: UIView?
    var lenFocusLabelView: UIView?
    
    private var messageLabel: MessageLabel!
    
    var allViews: [UIView] {
        get {
            var views: [UIView] = [collaborationButtonView,
                                   statisticButtonView,
                                   collaborationSettingView,
                                   statisticView,
                                   hintMessageLabelView]
            
            views.append(contentsOf: [confirmButtonView,
                          addRecordButtonView,
                          commonSettingButtonView,
                          commonSettingView,
                          objectDistanceLabelView,
                          virtualImageDistanceLabelView,
                          lenFocusLabelView]
                            .filter( {$0 != nil}) as! [UIView]
            )
            
            return views
        }
    }
    
    
    
    // MARK: - View Models
    
    private var collaborationSettingViewModel = CollaborationSettingViewModel()
    private var collaborationSettingUpdateObservers: [Cancellable] = []
    
    var convexLabViewModel = ConvexLabViewModel()
    
    var objectDistanceLabelViewModel = DistanceLabelViewModel()
    var virtualImageDistanceLabelViewModel = DistanceLabelViewModel()
    var lenFocusLabelViewModel = DistanceLabelViewModel()
    
    var convexLabCommonSettingViewModel = ConvexLabCommonSettingViewModel()
    
    /// Used to keeping a reference of any subscriptions involving this entity
    var entitySubs: [Cancellable] = []
    
    var sceneUpdateObserver: Cancellable?
    
    // MARK: - Model Things
    
    private var loadedModel: Entity!
    private var circleEntity: Entity!
    
    private var heightOffset: Float {
        get {
            return loadedModel.findEntity(named: "Center")!.position.y
        }
    }
    
    private var focus: Float {
        get {
            return (self.loadedModel.findEntity(named: "Focus_Point_1x_1")!.position(relativeTo: nil) - self.loadedModel.findEntity(named: "Len")!.position(relativeTo: nil)).magnitude()
        }
    }
    
    private var modelCenter: Entity {
        get {
            self.loadedModel.findEntity(named: "Center")!
        }
    }
    
    private var lenCenter: Entity {
        get {
            self.loadedModel.findEntity(named: "Len_Center")!
        }
    }
    
    private var boardOneCenter: Entity {
        get {
            self.loadedModel.findEntity(named: "Board1_Center")!
        }
    }
    
    private var boardTwoCenter: Entity {
        get {
            self.loadedModel.findEntity(named: "Board2_Center")!
        }
    }
    
    private var virtualF: Entity {
        get {
            self.loadedModel.findEntity(named: "VF")!
        }
    }
    
    private enum AnimationState {
        case normal
        case animating(controller: AnimationPlaybackController)
    }
    
    // MARK: - Game State
//    private var readyToPlace = false
//    private var modelPlaced = false
//    private var confirmed = false
    private var labState = ConvexLabStateEntity()
    private var circleAnimationState: AnimationState = .normal
    private var modelAnimationState: AnimationState = .normal
    private var modelARAnchor: ARAnchor?
    private var modelAnchorEntity: AnchorEntity?
    private var stateAnchorEntity: AnchorEntity?
    private var hitEntity: Entity?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Component registrition
        ConvexLabStateComponent.registerComponent()
        
        self.messageLabel = MessageLabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.topAnchor.constraint(equalTo: view.topAnchor),
            messageLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            messageLabel.heightAnchor.constraint(equalToConstant: 100.0)
        ])
        
        arView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(handleTap(recognizer:))
            ))
        
        arView.addGestureRecognizer(
            UIPanGestureRecognizer(
                target: self,
                action: #selector(handlePan(_:))
            ))
        
        loadedModel = try! Entity.load(named: "Convex_new")
        circleEntity = try! Entity.load(named: "Circle")
        setupLoadedModel(model: loadedModel)
        
        setupButtons()
        setUpLeftButtonView()
        setupCollaborationSettingView()
        setupStatisticView()
//        setupCommonSettingView()
        setupHintMessageLabelView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        arView.session.delegate = self
        
        self.sceneUpdateObserver = self.arView.scene.subscribe(to: SceneEvents.Update.self) { [unowned self] event in
            if !self.collaborationSettingViewModel.collaborationEnabled || self.collaborationSettingViewModel.peerType == .host {
                self.setupFocusModel(event: event)
            }
            self.setupDistanceLabelData()
        }
        
        collaborationSettingUpdateObservers.append(collaborationSettingViewModel.$collaborationEnabled.sink { value in
            if value {
                if let serviceType = self.serviceType {
                    self.setupMultipeerSession(serviceType: serviceType,
                                               peerType: self.collaborationSettingViewModel.peerType,
                                               receivedDataHandler: self.dataReceived,
                                               peerJoinedHandler: self.peerJoined,
                                               peerLeftHandler: self.peerLeft,
                                               peerDiscoveredHandler: self.peerDiscovered,
                                               peerInvitationdHandler: self.peerInvited)
                    self.messageLabel.displayMessage("Setup multipeer session as \(self.collaborationSettingViewModel.peerType).")
                }
                
                // 开启时，若是 host 开始检测
                if self.collaborationSettingViewModel.peerType == .host {
                    self.sceneUpdateObserver = self.arView.scene.subscribe(to: SceneEvents.Update.self) { [unowned self] event in
                        self.setupFocusModel(event: event)
                        self.setupDistanceLabelData()
                    }
                } else {
                    self.unsetupMultipeerSession()
                    self.resetLab()
                }
            } else {
                self.unsetupMultipeerSession()
                self.resetLab()
                
                self.messageLabel.displayMessage("Disable collaborative session.")
                
                // 关闭时开始检测
                self.sceneUpdateObserver = self.arView.scene.subscribe(to: SceneEvents.Update.self) { [unowned self] event in
                    self.setupFocusModel(event: event)
                    self.setupDistanceLabelData()
                }
            }
            
            
        })
        
        // TODO: - to be guest
        collaborationSettingUpdateObservers.append(collaborationSettingViewModel.$peerType.sink { value in
            self.unsetupMultipeerSession()
            self.resetLab()
            
            if self.collaborationSettingViewModel.collaborationEnabled {
                self.setupMultipeerSession(serviceType: self.serviceType!,
                                           peerType: value,
                                           receivedDataHandler: self.dataReceived,
                                           peerJoinedHandler: self.peerJoined,
                                           peerLeftHandler: self.peerLeft,
                                           peerDiscoveredHandler: self.peerDiscovered,
                                           peerInvitationdHandler: self.peerInvited)
                self.messageLabel.displayMessage("Setup multipeer session as \(value).")
            }
            
            if value == .host {
                self.sceneUpdateObserver = self.arView.scene.subscribe(to: SceneEvents.Update.self) { [unowned self] event in
                    self.setupFocusModel(event: event)
                    self.setupDistanceLabelData()
                }
            } else if value == .guest{
            }
        })
    }
    
    // MARK: - View Setups
    private func generateARButton(systemName: String, fontSize: CGFloat = 20, action: @escaping () -> Void, blurEffect: UIBlurEffect.Style = .systemThinMaterial, contrainGenerator: (UIView) -> [NSLayoutConstraint]) -> UIHostingController<ARButtonWithBlurBackground> {
        let arButton = ARButtonWithBlurBackground(systemName: systemName, fontSize: fontSize, action: action, blurEffect: blurEffect)
        let hostingViewController = UIHostingController(rootView: arButton)
        self.addChild(hostingViewController)
        self.view.addSubview(hostingViewController.view)
        hostingViewController.didMove(toParent: self)
        hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingViewController.view.backgroundColor = .clear
        NSLayoutConstraint.activate(contrainGenerator(hostingViewController.view))
        
        return hostingViewController
    }
    
    func setupButtons() {
        self.collaborationButtonView = generateARButton(systemName: "person.2") {
            UIView.transition(with: self.collaborationSettingView, duration: 0.5, options: .curveEaseInOut, animations: {
                self.collaborationSettingView.alpha = 1 - self.collaborationSettingView.alpha
            }, completion: nil)
        } contrainGenerator: { hostingView in
            [
                hostingView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
                hostingView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            ]
        }.view
        
//        self.statisticButtonView = generateARButton(systemName: "chart.bar.xaxis", fontSize: 22, action: {
//            UIView.transition(with: self.statisticView, duration: 0.5, options: .curveEaseInOut, animations: {
//                self.statisticView.alpha = 1 - self.statisticView.alpha
//            }, completion: nil)
//            self.convexLabViewModel.accmumulatedRecordNumber.send(self.convexLabViewModel.number + 1)
//        }) { hostingView in
//            [
//                hostingView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
//                hostingView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
//            ]
//        }.view
        
        let arButton = ARButtonWithBlurBackground(systemName: "chart.bar.xaxis", fontSize: 22, action: {
            UIView.transition(with: self.statisticView, duration: 0.5, options: .curveEaseInOut, animations: {
                self.statisticView.alpha = 1 - self.statisticView.alpha
            }, completion: nil)
            self.convexLabViewModel.accmumulatedRecordNumber.send(0)
        }, blurEffect: .systemThinMaterial)
        .cautionCircle(numberModel: self.convexLabViewModel)
        
        let hostingViewController = UIHostingController(rootView: arButton)
        self.addChild(hostingViewController)
        self.view.addSubview(hostingViewController.view)
        hostingViewController.didMove(toParent: self)
        hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingViewController.view.backgroundColor = .clear
        NSLayoutConstraint.activate([
            hostingViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            hostingViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
        ])
        self.statisticButtonView = hostingViewController.view
        
//        self.commonSettingButtonView = generateARButton(systemName: "gearshape", fontSize: 22) {
//            if self.confirmed {
//                UIView.transition(with: self.commonSettingView, duration: 0.5, options: .curveEaseInOut, animations: {
//                    self.commonSettingView.alpha = 1 - self.commonSettingView.alpha
//                }, completion: nil)
//            }
//        } contrainGenerator: { hostingView in
//            [
//                hostingView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
//                hostingView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
//            ]
//        }.view
//        self.setupSettingButton()
        // Setup after confirm
    }
    
    func setUpLeftButtonView() {
        self.leftButtonView = generateARButton(systemName: "arrow.uturn.backward") {
            self.leftAction?()
        } contrainGenerator: { hostingView in
            [
                hostingView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
                hostingView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            ]
        }.view
    }
    
    func setupCollaborationSettingView() {
        let collaborationSettingView = CollaborationSettingView(model: collaborationSettingViewModel)
        let hostingViewController = UIHostingController(rootView: collaborationSettingView)
        self.addChild(hostingViewController)
        self.view.addSubview(hostingViewController.view)
        hostingViewController.didMove(toParent: self)
        hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingViewController.view.backgroundColor = .clear
        NSLayoutConstraint.activate([
            hostingViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            hostingViewController.view.topAnchor.constraint(equalTo: collaborationButtonView.bottomAnchor, constant: 16),
        ])
        
        self.collaborationSettingView = hostingViewController.view
        self.collaborationSettingView.alpha = 0
    }
    
    func setupStatisticView() {
        let statisticView = ConvexLabStatisticView(convexLabViewModel: self.convexLabViewModel)
        let hostingViewController = UIHostingController(rootView: statisticView)
        self.addChild(hostingViewController)
        self.view.addSubview(hostingViewController.view)
        hostingViewController.didMove(toParent: self)
        hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingViewController.view.backgroundColor = .clear
        NSLayoutConstraint.activate([
            hostingViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            hostingViewController.view.topAnchor.constraint(equalTo: statisticButtonView.bottomAnchor, constant: 16),
        ])
        
        self.statisticView = hostingViewController.view
        self.statisticView.alpha = 0
    }
    
    func setupCommonSettingView() {
        let commonSettingView = ConvexLabCommonSettingView(model: convexLabCommonSettingViewModel)
        let hostingViewController = UIHostingController(rootView: commonSettingView)
        self.addChild(hostingViewController)
        self.view.addSubview(hostingViewController.view)
        hostingViewController.didMove(toParent: self)
        hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingViewController.view.backgroundColor = .clear
        NSLayoutConstraint.activate([
            hostingViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            hostingViewController.view.bottomAnchor.constraint(equalTo: commonSettingButtonView!.topAnchor, constant: -16),
        ])
        
        self.commonSettingView = hostingViewController.view
        self.commonSettingView!.alpha = 0
        
        convexLabCommonSettingViewModel.cancellables.append(convexLabCommonSettingViewModel.$showRealVirtualImage.sink { value in
            self.virtualF.isEnabled = value
        })
        
        convexLabCommonSettingViewModel.cancellables.append(convexLabCommonSettingViewModel.$showFocusPoint.sink { value in
            self.loadedModel.findEntity(named: "Focus_Point_1x_1_Ball")!.isEnabled = value
            self.loadedModel.findEntity(named: "Focus_Point_2x_1_Ball")!.isEnabled = value
            self.loadedModel.findEntity(named: "Focus_Point_1x_2_Ball")!.isEnabled = value
            self.loadedModel.findEntity(named: "Focus_Point_2x_2_Ball")!.isEnabled = value
        })
        
        convexLabCommonSettingViewModel.cancellables.append(convexLabCommonSettingViewModel.$showDistanceLabels.sink { value in
            if let virtualImageDistanceLabelView = self.virtualImageDistanceLabelView,
               let objectDistanceLabelView = self.objectDistanceLabelView,
               let lenFocusLabelView = self.lenFocusLabelView {
                    UIView.transition(with: virtualImageDistanceLabelView, duration: 0.5, options: .curveEaseInOut, animations: {
                        virtualImageDistanceLabelView.alpha = value ? (self.convexLabCommonSettingViewModel.showVirtualImageDistanceLabel ? 1 : 0) : 0
                    }, completion: nil)
                    UIView.transition(with: objectDistanceLabelView, duration: 0.5, options: .curveEaseInOut, animations: {
                        objectDistanceLabelView.alpha = value ? (self.convexLabCommonSettingViewModel.showObjectDistanceLabel ? 1 : 0) : 0
                    }, completion: nil)
                    UIView.transition(with: lenFocusLabelView, duration: 0.5, options: .curveEaseInOut, animations: {
                        lenFocusLabelView.alpha = value ? (self.convexLabCommonSettingViewModel.showLenFocusLabel ? 1 : 0) : 0
                    }, completion: nil)
            }
        })
        
        convexLabCommonSettingViewModel.cancellables.append(convexLabCommonSettingViewModel.$showObjectDistanceLabel.sink { value in
            if let objectDistanceLabelView = self.objectDistanceLabelView {
                UIView.transition(with: objectDistanceLabelView, duration: 0.5, options: .curveEaseInOut, animations: {
                    objectDistanceLabelView.alpha = value ? 1 : 0
                }, completion: nil)
            }
        })
        
        convexLabCommonSettingViewModel.cancellables.append(convexLabCommonSettingViewModel.$showVirtualImageDistanceLabel.sink { value in
            if let virtualImageDistanceLabelView = self.virtualImageDistanceLabelView {
                UIView.transition(with: virtualImageDistanceLabelView, duration: 0.5, options: .curveEaseInOut, animations: {
                    virtualImageDistanceLabelView.alpha = value ? 1 : 0
                }, completion: nil)
            }
        })
        
        convexLabCommonSettingViewModel.cancellables.append(convexLabCommonSettingViewModel.$showLenFocusLabel.sink { value in
            if let lenFocusLabelView = self.lenFocusLabelView {
                UIView.transition(with: lenFocusLabelView, duration: 0.5, options: .curveEaseInOut, animations: {
                    lenFocusLabelView.alpha = value ? 1 : 0
                }, completion: nil)
            }
        })
    }
    
    func setupCommonSettingButtonView() {
        let arButton = ARButtonWithBlurBackground(systemName: "gearshape", fontSize: 22, action: {
            if self.labState.confirmed {
                UIView.transition(with: self.commonSettingView!, duration: 0.5, options: .curveEaseInOut, animations: {
                    self.commonSettingView!.alpha = 1 - self.commonSettingView!.alpha
                }, completion: nil)
            }
        }, blurEffect: .systemThinMaterial)
        .topLeftPopoverWithArrow(text: "更改辅助显示")
        
        let hostingViewController = UIHostingController(rootView: arButton)
        self.addChild(hostingViewController)
        self.view.addSubview(hostingViewController.view)
        hostingViewController.didMove(toParent: self)
        hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingViewController.view.backgroundColor = .clear
        NSLayoutConstraint.activate([
            hostingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            hostingViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        ])
        
        self.commonSettingButtonView = hostingViewController.view
    }
    
    func setupHintMessageLabelView() {
        let hintMessageLabel = HintMessageLabel(textModel: convexLabViewModel)
        let hostingViewController = UIHostingController(rootView: hintMessageLabel)
        self.addChild(hostingViewController)
        self.view.addSubview(hostingViewController.view)
        hostingViewController.didMove(toParent: self)
        hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingViewController.view.backgroundColor = .clear
        NSLayoutConstraint.activate([
            hostingViewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hostingViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
        ])
        
        self.hintMessageLabelView = hostingViewController.view
    }
    
    func showConfirmButton() {
        let arButton = ARButtonWithPureBackground(systemName: "checkmark.circle.fill", fontSize: 60, action: {
            UIView.transition(with: self.confirmButtonView!, duration: 0.5, options: .curveEaseInOut, animations: {
                self.confirmButtonView!.alpha = 1 - self.confirmButtonView!.alpha
            }, completion: { completed in
                if completed {
                    self.convexLabViewModel.hintMessage.send("拖动物体与光屏以改变物距和像距。\n观察光屏上所成的像。")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.showAddRecordButton()
                    }
                    
                    self.setupCommonSettingButtonView()
                    self.setupCommonSettingView()
                }
            })
            
            self.labState.confirmed = true
            // TODO: - BUG HERE
            let cube = self.loadedModel.findEntity(named: "Gesture Cube")!
            let cubeTransform = cube.transform
            let emptyEntity = Entity()
            emptyEntity.setParent(cube.parent!)
            emptyEntity.setScale(cubeTransform.scale, relativeTo: cube.parent!)
            emptyEntity.setPosition(cubeTransform.translation, relativeTo: cube.parent!)
            emptyEntity.setOrientation(cubeTransform.rotation, relativeTo: cube.parent!)
            
            for child in cube.children {
                let originalPosition = child.position(relativeTo: nil)
                child.setParent(emptyEntity)
                child.setPosition(originalPosition, relativeTo: nil)
            }
            cube.removeFromParent()
            
            self.setupDistanceLabelView()
            // 已经保证是 host
            self.multipeerSession?.sendToAllPeers(Data("confirm".utf8))
        })
        .leftPopoverWithArrow(text: "确认模型位置")
        
        let hostingViewController = UIHostingController(rootView: arButton)
        self.addChild(hostingViewController)
        self.view.addSubview(hostingViewController.view)
        hostingViewController.didMove(toParent: self)
        hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingViewController.view.backgroundColor = .clear
        NSLayoutConstraint.activate([
            hostingViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            hostingViewController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        self.confirmButtonView = hostingViewController.view
        
        hostingViewController.view.alpha = 0
        UIView.transition(with: self.confirmButtonView!, duration: 0.5, options: .curveEaseInOut, animations: {
            self.confirmButtonView!.alpha = 1 - self.confirmButtonView!.alpha
        }, completion: nil)
    }
    
    func showAddRecordButton() {
        let arButton = ARButtonWithPureBackground(systemName: "plus.circle.fill", fontSize: 60, action: {
            // TODO: - 只会提醒一次的 Bug
            self.convexLabViewModel.hintMessage.send("")
            self.convexLabViewModel.hintMessage.send("新的实验数据已记录。")
            
            let objectDistance = (self.boardOneCenter.position(relativeTo: nil) - self.lenCenter.position(relativeTo: nil)).magnitude()
            let virtualImageDistance = (self.boardTwoCenter.position(relativeTo: nil) - self.lenCenter.position(relativeTo: nil)).magnitude()
            let virtualImageDirection: ConvexLabViewModel.ConvexLabRecord.VirtualImageDirection = objectDistance < self.focus ? .up : .down
            let virtualImageScaleValue = virtualImageDistance / objectDistance
            var virtualImageScale: ConvexLabViewModel.ConvexLabRecord.VirtualImageScale = .smaller
            if (0.95..<1.05).contains(virtualImageScaleValue) {
                virtualImageScale = .almostEqualLarge
            } else if virtualImageScaleValue < 0.95 {
                virtualImageScale = .smaller
            } else {
                virtualImageScale = .larger
            }
            let virtualImageType: ConvexLabViewModel.ConvexLabRecord.VirtualImageType = objectDistance < self.focus ? .virtual : .real
            
            let vfScale = self.focus / (objectDistance - self.focus)
            var isInaccurateRecord = !(0.95...1.05).contains(virtualImageScaleValue / vfScale)
            isInaccurateRecord =  objectDistance < self.focus ? true : isInaccurateRecord
            
            
            if isInaccurateRecord {
                self.convexLabViewModel.hintMessage.send("在得到清晰的像时记录才能保证数据准确。")
            }
            
            if self.statisticView.alpha == 0 {
                self.convexLabViewModel.accmumulatedRecordNumber.send(self.convexLabViewModel.number + 1)
                print("send: \(self.convexLabViewModel.number + 1)")
            }
            
            self.convexLabViewModel.records.append(.init(focusDistance: self.focus, objectDistance: objectDistance, virtualImageBoardDistance: virtualImageDistance, isInaccurateRecord: isInaccurateRecord, virtualImageDirection: virtualImageDirection, virtualImageScale: virtualImageScale, virtualImageType: virtualImageType))
        })
        .leftPopoverWithArrow(text: "点击记录实验数据")
        
        let hostingViewController = UIHostingController(rootView: arButton)
        self.addChild(hostingViewController)
        self.view.insertSubview(hostingViewController.view, belowSubview: self.collaborationSettingView)
        hostingViewController.didMove(toParent: self)
        hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingViewController.view.backgroundColor = .clear
        NSLayoutConstraint.activate([
            hostingViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            hostingViewController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        self.addRecordButtonView = hostingViewController.view
        
        hostingViewController.view.alpha = 0
        UIView.transition(with: addRecordButtonView!, duration: 0.5, options: .curveEaseInOut, animations: {
            self.addRecordButtonView!.alpha = 1 - self.addRecordButtonView!.alpha
        }, completion: nil)
    }
    
    func setupDistanceLabelView() {
        let objectDistanceLabelView = DistanceLabelView(model: objectDistanceLabelViewModel)
        let hostingViewController = UIHostingController(rootView: objectDistanceLabelView)
        self.addChild(hostingViewController)
        self.view.insertSubview(hostingViewController.view, aboveSubview: self.arView)
        hostingViewController.didMove(toParent: self)
        hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingViewController.view.backgroundColor = .clear
        hostingViewController.view.isUserInteractionEnabled = false
        NSLayoutConstraint.activate([
            hostingViewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hostingViewController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            hostingViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            hostingViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor),
            
        ])
        self.objectDistanceLabelView = hostingViewController.view
        self.objectDistanceLabelView!.alpha = 0
        
        let virtualImageDistanceLabelView = DistanceLabelView(model: virtualImageDistanceLabelViewModel)
        let hostingViewController2 = UIHostingController(rootView: virtualImageDistanceLabelView)
        self.addChild(hostingViewController2)
        self.view.insertSubview(hostingViewController2.view, aboveSubview: self.arView)
        hostingViewController2.didMove(toParent: self)
        hostingViewController2.view.translatesAutoresizingMaskIntoConstraints = false
        hostingViewController2.view.backgroundColor = .clear
        hostingViewController2.view.isUserInteractionEnabled = false
        NSLayoutConstraint.activate([
            hostingViewController2.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hostingViewController2.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            hostingViewController2.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            hostingViewController2.view.heightAnchor.constraint(equalTo: view.heightAnchor),
            
        ])
        self.virtualImageDistanceLabelView = hostingViewController2.view
        self.virtualImageDistanceLabelView!.alpha = 0
        
        let lenFocusLabelView = DistanceLabelView(model: lenFocusLabelViewModel)
        let hostingViewController3 = UIHostingController(rootView: lenFocusLabelView)
        self.addChild(hostingViewController3)
        self.view.insertSubview(hostingViewController3.view, aboveSubview: self.arView)
        hostingViewController3.didMove(toParent: self)
        hostingViewController3.view.translatesAutoresizingMaskIntoConstraints = false
        hostingViewController3.view.backgroundColor = .clear
        hostingViewController3.view.isUserInteractionEnabled = false
        NSLayoutConstraint.activate([
            hostingViewController3.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hostingViewController3.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            hostingViewController3.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            hostingViewController3.view.heightAnchor.constraint(equalTo: view.heightAnchor),
            
        ])
        self.lenFocusLabelView = hostingViewController3.view
        self.lenFocusLabelView!.alpha = 0
        
        UIView.transition(with: self.objectDistanceLabelView!, duration: 0.5, options: .curveEaseInOut, animations: {
            self.objectDistanceLabelView!.alpha = 1 - self.objectDistanceLabelView!.alpha
        }, completion: nil)
        
        UIView.transition(with: self.virtualImageDistanceLabelView!, duration: 0.5, options: .curveEaseInOut, animations: {
            self.virtualImageDistanceLabelView!.alpha = 1 - self.virtualImageDistanceLabelView!.alpha
        }, completion: nil)
        
//        UIView.transition(with: self.lenFocusLabelView!, duration: 0.5, options: .curveEaseInOut, animations: {
//            self.lenFocusLabelView!.alpha = 1 - self.lenFocusLabelView!.alpha
//        }, completion: nil)
    }
    
    func setupGestureGuide() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        backgroundView.frame = self.view.bounds
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundView.alpha = 0
        backgroundView.tag = 12345
        self.view.addSubview(backgroundView)
        self.view.insertSubview(self.hintMessageLabelView, aboveSubview: backgroundView)
        
        let gestureAnimationView = AnimationView(name: "pinch_gesture2")
        gestureAnimationView.frame = backgroundView.bounds
        gestureAnimationView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundView.addSubview(gestureAnimationView)
        gestureAnimationView.alpha = 0
        UIView.transition(with: backgroundView, duration: 0.5, options: .curveEaseInOut, animations: {
            backgroundView.alpha = 1
        }, completion: { completed in
            if completed {
                UIView.transition(with: gestureAnimationView, duration: 0.5, options: .curveEaseInOut, animations: {
                    gestureAnimationView.alpha = 1
                }, completion: nil)
                
                gestureAnimationView.play { completed in
                    if completed {
                        UIView.transition(with: backgroundView, duration: 0.5, options: .curveEaseInOut, animations: {
                            backgroundView.alpha = 0
                        }, completion: { completed in
                            if completed {
                                backgroundView.removeFromSuperview()
                            }
                        })
                    }
                }
            }
        })
        
        backgroundView.addGestureRecognizer(
            UITapGestureRecognizer(
            target: self,
            action: #selector(touchDownAction(recognizer:))
        ))
    }
    
    @objc
    private func touchDownAction(recognizer: UITapGestureRecognizer) {
        for view in self.view.subviews where view.tag == 12345 {
            UIView.transition(with: view, duration: 0.5, options: .curveEaseInOut, animations: {
                view.alpha = 0
            }, completion: { completed in
                if completed {
                    view.removeFromSuperview()
                }
            })
        }
    }
    
    // MARK: - Model Setups
    func setupLoadedModel(model: Entity) {
//        model.setPosition(SIMD3<Float>(x: 0, y: -heightOffset * 0.05, z: 0), relativeTo: nil)
        model.setScale([0.05, 0.05, 0.05], relativeTo: nil)
        model.synchronization?.ownershipTransferMode = .autoAccept
        let base = model.findEntity(named: "_Base")! as! ModelEntity
        let material = SimpleMaterial(color: UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1), isMetallic: true)
        let material2 = SimpleMaterial(color: UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), isMetallic: false)
        base.model?.materials = [material]
        let board1 = model.findEntity(named: "Board1")! as! ModelEntity
        board1.model?.materials  = [material2]
        let board2 = model.findEntity(named: "Board2")! as! ModelEntity
        board2.model?.materials  = [material2]
        let len = model.findEntity(named: "Len")! as! ModelEntity
        len.model?.materials  = [material]
        
        board1.synchronization?.ownershipTransferMode = .manual
        board2.synchronization?.ownershipTransferMode = .manual
        
//        let boundingBox = model.visualBounds(relativeTo: nil)
//        let cube = ModelEntity(mesh: .generateBox(size: 0), materials: [SimpleMaterial()])
//        cube.position = boundingBox.center
//        cube.generateCollisionShapes(recursive: true)
//        arView.installGestures(for: cube)
//        
//        model.addChild(cube)
//        model.findEntity(named: "Convex_new")!.setParent(cube)
        
//        model.findEntity(named: "Board1")!.generateCollisionShapes(recursive: false)
//        model.findEntity(named: "Board2")!.generateCollisionShapes(recursive: false)
        
        let vfImage = model.findEntity(named: "VF_image")! as! ModelEntity
        vfImage.model?.materials = [UnlitMaterial(color: UIColor(red: 1, green: 0.28, blue: 0.28, alpha: 0.25))]
    }
    
    func setupFocusModel(event: SceneEvents.Update) {
        // Only host peer process focus
        if labState.modelPlaced == false {
            let focusPoint = CGPoint(x: self.arView.center.x, y: self.arView.center.y - self.arView.center.y * 0.15)
            if let query = self.arView.makeRaycastQuery(from: focusPoint, allowing: .existingPlaneGeometry, alignment: .horizontal),
               let match = self.arView.session.raycast(query).first {
                loadedModel.isEnabled = true
                circleEntity.isEnabled = true
                if self.modelARAnchor == nil,
                   self.modelAnchorEntity == nil,
                   self.stateAnchorEntity == nil {
                    let arAnchor = ARAnchor(name: "Convex Model ARAnchor", transform: match.worldTransform)
                    let modelAnchorEntity = AnchorEntity(anchor: arAnchor)
                    modelAnchorEntity.name = "Convex Model AnchorEntity"
                    modelAnchorEntity.addChild(loadedModel)
                    modelAnchorEntity.addChild(circleEntity)
                    modelAnchorEntity.anchoring = AnchoringComponent(arAnchor)
                    let labStateAnchorEntity = AnchorEntity(anchor: arAnchor)
                    labStateAnchorEntity.name = "Convex Lab State AnchorEntity"
                    labStateAnchorEntity.addChild(self.labState)
                    labStateAnchorEntity.anchoring = AnchoringComponent(arAnchor)
                    
                    arView.scene.addAnchor(modelAnchorEntity)
                    arView.scene.addAnchor(labStateAnchorEntity)
                    arView.session.add(anchor: arAnchor)
                    
                    let emptyEntity = Entity()
                    emptyEntity.name = "Center_Copy"
                    emptyEntity.setParent(modelCenter)
                    emptyEntity.setPosition(.zero, relativeTo: modelCenter)
                    
                    while modelCenter.children.count > 1 {
                        let child = modelCenter.children.randomElement()!
//                        print(child.name)
                        if child.name != "Center_Copy" {
                            let originalPosition = child.position(relativeTo: nil)
                            child.setParent(emptyEntity)
                            child.setPosition(originalPosition, relativeTo: nil)
                        }
                    }
                    
                    self.modelARAnchor = arAnchor
                    self.modelAnchorEntity = modelAnchorEntity
                    self.stateAnchorEntity = labStateAnchorEntity
                }
                
                let transform = Transform(matrix: match.worldTransform)
                
                modelCenter.setPosition([transform.translation.x, transform.translation.y + 0.05, transform.translation.z], relativeTo: nil)
                modelCenter.setOrientation(transform.rotation, relativeTo: nil)
                modelCenter.setOrientation(simd_quatf(angle: .pi, axis: [0, 1, 0]), relativeTo: modelCenter)
                circleEntity.setPosition(transform.translation, relativeTo: nil)
                
                switch circleAnimationState {
                case .normal:
                    var transform = circleEntity.transform
                    transform.scale = [1.5, 1.5, 1.5]
                    self.circleAnimationState = .animating(controller: circleEntity.move(to: transform, relativeTo: circleEntity, duration: 1, timingFunction: .easeInOut))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.05) {
                        switch self.circleAnimationState {
                        case .animating(_):
                            var transform = self.circleEntity.transform
                            transform.scale = [0.6666666, 0.6666666, 0.6666666]
                            self.circleAnimationState = .animating(controller: self.circleEntity.move(to: transform, relativeTo: self.circleEntity, duration: 1, timingFunction: .easeInOut))
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.05) {
                                self.circleAnimationState = .normal
                            }
                        default:
                            break
                        }
                    }
                case .animating:
                    break
                }
                
                let centerCopy = modelCenter.findEntity(named: "Center_Copy")!
//                print(centerCopy.transform.translation)
                
                switch modelAnimationState {
                case .normal:
                    var transform = Transform(matrix: centerCopy.transformMatrix(relativeTo: nil))
                    transform.translation = [transform.translation.x, transform.translation.y - 0.03, transform.translation.z]
                    self.modelAnimationState = .animating(controller: centerCopy.move(to: transform, relativeTo: nil, duration: 1, timingFunction: .easeInOut))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.05) {
                        switch self.circleAnimationState {
                        case .animating(_):
                            var transform = Transform(matrix: centerCopy.transformMatrix(relativeTo: nil))
                            transform.translation = [transform.translation.x, transform.translation.y + 0.03, transform.translation.z]
                            self.modelAnimationState = .animating(controller: centerCopy.move(to: transform, relativeTo: nil, duration: 1, timingFunction: .easeInOut))
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.05) {
                                self.modelAnimationState = .normal
                            }
                        default:
                            break
                        }
                    }
                case .animating:
                    break
                }
                
                labState.readyToPlace = true
                self.convexLabViewModel.hintMessage.send("单击屏幕放置模型")
            } else {
                labState.readyToPlace = false
                loadedModel.isEnabled = false
                circleEntity.isEnabled = false
                self.convexLabViewModel.hintMessage.send("查找附近的平面并放置模型")
            }
        }
    }
    
    func setupDistanceLabelData() {
        self.objectDistanceLabelViewModel.startPoint = arView.project(loadedModel.findEntity(named: "Board1")?.position(relativeTo: nil) ?? .zero) ?? .zero
        self.objectDistanceLabelViewModel.endPoint = arView.project(loadedModel.findEntity(named: "Len")?.position(relativeTo: nil) ?? .zero) ?? .zero
        self.objectDistanceLabelViewModel.distance = (self.boardOneCenter.position(relativeTo: nil) - self.lenCenter.position(relativeTo: nil)).magnitude()
        self.objectDistanceLabelViewModel.focus = self.focus
        
        self.virtualImageDistanceLabelViewModel.startPoint = arView.project(loadedModel.findEntity(named: "Board2")?.position(relativeTo: nil) ?? .zero) ?? .zero
        self.virtualImageDistanceLabelViewModel.endPoint = arView.project(loadedModel.findEntity(named: "Len")?.position(relativeTo: nil) ?? .zero) ?? .zero
        self.virtualImageDistanceLabelViewModel.distance = (self.boardTwoCenter.position(relativeTo: nil) - self.lenCenter.position(relativeTo: nil)).magnitude()
        self.virtualImageDistanceLabelViewModel.focus = self.focus
        
        self.lenFocusLabelViewModel.startPoint = arView.project(loadedModel.findEntity(named: "Focus_Label_Start")?.position(relativeTo: nil) ?? .zero) ?? .zero
        self.lenFocusLabelViewModel.endPoint = arView.project(loadedModel.findEntity(named: "Focus_Label_End")?.position(relativeTo: nil) ?? .zero) ?? .zero
        self.lenFocusLabelViewModel.distance = self.focus
        self.lenFocusLabelViewModel.focus = self.focus
    }
    
    // MARK: - MultipeerConnectivity Handlers
    
    func dataReceived(_ data: Data, peer: MCPeerID) -> Void {
        if peer != (self.arView.scene.synchronizationService as? MultipeerConnectivityService)?.session.myPeerID {
            if let event = String(data: data, encoding: .utf8) {
                print("event: \(event)")
                switch event {
                case "confirm", "already confirmed":
                    if objectDistanceLabelView == nil,
                       virtualImageDistanceLabelView == nil,
                       lenFocusLabelView == nil,
                       commonSettingButtonView == nil,
                       commonSettingView == nil {
                        // When confirm, show data label and setting views.
                        DispatchQueue.main.async {
                            self.setupDistanceLabelView()
                            self.sceneUpdateObserver = self.arView.scene.subscribe(to: SceneEvents.Update.self) { [unowned self] event in
                                self.setupDistanceLabelData()
                            }
                            
                            self.convexLabViewModel.hintMessage.send("拖动物体与光屏以改变物距和像距。\n观察光屏上所成的像。")
                            self.showAddRecordButton()
                            
                            self.setupCommonSettingButtonView()
                            self.setupCommonSettingView()
                        }
                    }
                default:
                    break;
                }
            }
        }
    }
    
    func peerJoined(_ peer: MCPeerID) {
        messageLabel.displayMessage("""
            A peer(\(peerName[peer] ?? "unknown")) wants to join the experience.
            Hold the phones next to each other.
            """, duration: 6.0)
        self.convexLabViewModel.hintMessage.send("(\(peerName[peer] ?? "unknown")) 想要加入实验.")
    }
    
    func peerLeft(_ peer: MCPeerID) {
        messageLabel.displayMessage("A peer(\(peerName[peer] ?? "unknown")) has left the shared experience.")
        self.convexLabViewModel.hintMessage.send("(\(peerName[peer] ?? "unknown")) 离开了.")
    }
    
    func peerDiscovered(_ peer: MCPeerID, _ info: [String: String]?) -> Bool {
        if let info = info,
           let name = info["name"] {
            peerName[peer] = name
        } else {
            peerName[peer] = "unknown"
        }
        
        messageLabel.displayMessage("Find a peer(\(peerName[peer] ?? "unknown"))", duration: 6.0)
        self.convexLabViewModel.hintMessage.send("发现了\(peerName[peer] ?? "unknown").")
        return true
    }
    
    func peerInvited(_ peer: MCPeerID, _ info: [String: String]?) -> Bool {
        if let info = info,
           let name = info["name"] {
            peerName[peer] = name
        } else {
            peerName[peer] = "unknown"
        }
        
        messageLabel.displayMessage("Peer(\(peerName[peer] ?? "unknown")) invite you to join.", duration: 6.0)
        self.convexLabViewModel.hintMessage.send("\(peerName[peer] ?? "unknown") 邀请你加入实验")
        return true
    }
    
    // TODO: - RESETLAB
    func resetLab() {
        // Model
        loadedModel = try! Entity.load(named: "Convex_new")
        circleEntity = try! Entity.load(named: "Circle")
        setupLoadedModel(model: loadedModel)
        
        // Game State
        labState.readyToPlace = false
        labState.modelPlaced = false
        labState.confirmed = false
        circleAnimationState = .normal
        modelAnimationState = .normal
        
        
        if modelARAnchor != nil {
            self.arView.session.remove(anchor: modelARAnchor!)
            modelARAnchor = nil
        }
//
        if modelAnchorEntity != nil {
            modelAnchorEntity!.removeFromParent()
            modelAnchorEntity = nil
        }
        
        if stateAnchorEntity != nil {
            stateAnchorEntity!.removeFromParent()
            stateAnchorEntity = nil
        }
        
        hitEntity = nil
        
        // View Model
        convexLabViewModel.reset()
        objectDistanceLabelViewModel.reset()
        virtualImageDistanceLabelViewModel.reset()
        lenFocusLabelViewModel.reset()
        convexLabCommonSettingViewModel = ConvexLabCommonSettingViewModel()
        
        // Subscriber
        sceneUpdateObserver = nil
        
        // View
        confirmButtonView?.removeFromSuperview()
        confirmButtonView = nil
        
        addRecordButtonView?.removeFromSuperview()
        addRecordButtonView = nil
        
        commonSettingButtonView?.removeFromSuperview()
        commonSettingButtonView = nil
        commonSettingView?.removeFromSuperview()
        commonSettingView = nil
        
        
        objectDistanceLabelView?.removeFromSuperview()
        objectDistanceLabelView = nil
        virtualImageDistanceLabelView?.removeFromSuperview()
        virtualImageDistanceLabelView = nil
        lenFocusLabelView?.removeFromSuperview()
        lenFocusLabelView = nil
        
        // 消除残留的 Hint
        hintMessageLabelView.removeFromSuperview()
        setupHintMessageLabelView()
    }
    
    // MARK: - Gesture Recognizers
    
    @objc
    func handleTap(recognizer: UITapGestureRecognizer) {
        if collaborationSettingViewModel.collaborationEnabled == false || collaborationSettingViewModel.peerType == .host {
            if !labState.modelPlaced, labState.readyToPlace{
                self.circleEntity.isEnabled = false
                self.labState.modelPlaced = true
                
                switch self.circleAnimationState {
                    case let .animating(controller):
                        controller.stop()
                        self.circleAnimationState = .normal
                    default:
                        break;
                }
                
                let centerCopy = modelCenter.findEntity(named: "Center_Copy")!
    //            print("1: \(centerCopy.transform.translation)")
                
                switch self.modelAnimationState {
                    case let .animating(controller):
                        controller.stop()
                        self.modelAnimationState = .normal
    //                    print("2: \(centerCopy.transform.translation)")
                    default:
                        break;
                }
                
                let cube = ModelEntity(mesh: .generateBox(size: 0), materials: [SimpleMaterial()])
                cube.name = "Gesture Cube"
                
                loadedModel.addChild(cube)
                let originalPosition = modelCenter.position(relativeTo: nil)
                cube.setPosition([originalPosition.x, originalPosition.y - 0.05, originalPosition.z], relativeTo: nil)
                
                modelCenter.setParent(cube)
                modelCenter.setPosition(originalPosition, relativeTo: nil)
                
    //            let centerCopy = modelCenter.findEntity(named: "Center_Copy")!
                let modelCenterWorldTransform = Transform(matrix: modelCenter.transformMatrix(relativeTo: nil))
                var transform = Transform(matrix: centerCopy.transformMatrix(relativeTo: nil))
                transform.translation = [modelCenterWorldTransform.translation.x, modelCenterWorldTransform.translation.y - 0.05, modelCenterWorldTransform.translation.z]
                
                centerCopy.move(to: transform, relativeTo: nil, duration: 0.5, timingFunction: .easeInOut)
                // DON'T KNOW WHY IT'S NOT SYNCHRONIZED VIA THIS ANIMATION.
                // SO USE THIS TRICK TO FORCE SYNCHRONIZE STATE.
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
                    centerCopy.setTransformMatrix(transform.matrix, relativeTo: nil)
                }
                
                cube.generateCollisionShapes(recursive: true)
                arView.installGestures(for: cube)
                
                showConfirmButton()
                
                setupGestureGuide()
                
                self.convexLabViewModel.hintMessage.send("利用双指拖动旋转缩放光具座")
            }
    //        if model == nil, peerType == .host {
    //            let location = recognizer.location(in: arView)
    //            print("RC: \(location)")
    //
    //            let results = arView.raycast(from: location, allowing: .existingPlaneGeometry, alignment: .horizontal)
    //            if let firstResult = results.first {
    //                let arAnchor = ARAnchor(name: "Convex Model ARAnchor", transform: firstResult.worldTransform)
    //                let newAnchor = AnchorEntity(anchor: arAnchor)
    //
    //                newAnchor.addChild(loadedModel)
    //                newAnchor.anchoring = AnchoringComponent(arAnchor)
    //                arView.scene.addAnchor(newAnchor)
    //                arView.session.add(anchor: arAnchor)
    //
    //                //                showConfirmButton()
    //
    //                self.model = loadedModel
    //            } else {
    //                print("Warning: Object placement failed.")
    //            }
    //        }
        }
    }
    
    @objc func handlePan(_ panGesture: UIPanGestureRecognizer) {
        guard labState.confirmed else { return }
        
        guard let view = panGesture.view,
              let arView = view as? ARView else {
            return
        }
        
        let touchLocation = panGesture.location(in: arView)
        
        switch panGesture.state {
        case .began:
            guard let hitEntity = arView.entity(
                    at: touchLocation) else {
                // No entity was hit
                return
            }
            self.hitEntity = hitEntity
        case .changed:
            if let hitEntity = hitEntity {
                let entityName = hitEntity.name
                if (entityName == "Board1" || entityName == "Board2") {
                    hitEntity.requestOwnership { result in
                        if result == .granted {
                            let start3DPoint = arView.scene.findEntity(named: entityName + "_Start_Bound")!.position(relativeTo: nil)
                            let end3DPoint = arView.scene.findEntity(named: entityName + "_End_Bound")!.position(relativeTo: nil)
                            let start2DPoint = arView.project(start3DPoint)!
                            let end2DPoint = arView.project(end3DPoint)!
                            
                            let lineVector2D = SIMD2(startPoint: start2DPoint, endPoint: end2DPoint)
                            let touchVector2D = SIMD2(startPoint: start2DPoint, endPoint: touchLocation)
                            let scale = lineVector2D * touchVector2D / (lineVector2D * lineVector2D)
                            
                            let targetPosition = SIMD3.lerp(start: start3DPoint, end: end3DPoint, scale: scale)
                            
                            if (0...1).contains(scale) {
                                self.loadedModel.findEntity(named: entityName)!.setPosition(targetPosition, relativeTo: nil)
                            }
                        }
                    }
                    
                    if let rf = self.loadedModel.findEntity(named: "RF"),
                       let vf = self.loadedModel.findEntity(named: "VF"),
                       let vfImage = self.loadedModel.findEntity(named: "VF_image") as? ModelEntity {
                        let u = (self.boardOneCenter.position(relativeTo: nil) - self.lenCenter.position(relativeTo: nil)).magnitude()
                        let uu = (self.boardTwoCenter.position(relativeTo: nil) - self.lenCenter.position(relativeTo: nil)).magnitude() // VF_image
                        let vfImageScale = uu / u
                        let vfScale = self.focus / (u - self.focus)
                       
                        if entityName == "Board1" {
                            
                            vf.setScale(SIMD3<Float>(x: vfScale, y: vfScale, z: vfScale), relativeTo: rf)
                            vf.setPosition(self.lenCenter.position(relativeTo: nil) + (self.lenCenter.position(relativeTo: nil) - self.boardOneCenter.position(relativeTo: nil)).unit() * vfScale * u, relativeTo: nil)
                            
                            if (u < focus) {
                                vf.setOrientation(simd_quatf(angle: .pi, axis: [0, 1, 0]), relativeTo: vf.parent)
                            } else {
                                vf.setOrientation(simd_quatf(angle: .pi, axis: [0, 0, 1]), relativeTo: vf.parent)
                            }
                        }
                        
                        var x = vfImageScale / vfScale
                        x = x < 1 ? 1 / x : x
                        
                        var alpha = pow(0.003, x - 1)
                        alpha = alpha < 0.5 ? 0.5 - (0.5 - alpha) / 1.5 : alpha
                        
                        if (u > focus) {
                            vfImage.setScale(SIMD3<Float>(x: 0.1, y: vfImageScale, z: vfImageScale), relativeTo: rf)
                            vfImage.model?.materials = [UnlitMaterial(color: UIColor(red: 1, green: 0.28, blue: 0.28, alpha: CGFloat(alpha)))]
                        } else {
                            vfImage.setScale(SIMD3<Float>(x: 0, y: 0, z: 0), relativeTo: rf)
                        }
                    }
                }
            }
        default:
            hitEntity = nil
        }
    }
}


extension ConvexLabViewController: ARSessionDelegate  {
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let participantAnchor = anchor as? ARParticipantAnchor {
                messageLabel.displayMessage("Established joint experience with a peer.")
                // ...
                let anchorEntity = AnchorEntity(anchor: participantAnchor)
                
                let coordinateSystem = MeshResource.generateCoordinateSystemAxes()
                anchorEntity.addChild(coordinateSystem)
                
                let color = participantAnchor.sessionIdentifier?.toRandomColor() ?? .white
                let coloredSphere = ModelEntity(mesh: MeshResource.generateSphere(radius: 0.03),
                                                materials: [SimpleMaterial(color: color, isMetallic: true)])
                anchorEntity.addChild(coloredSphere)
                
                arView.scene.addAnchor(anchorEntity)
                
                if self.collaborationSettingViewModel.collaborationEnabled,
                   self.collaborationSettingViewModel.peerType == .host,
                   self.labState.confirmed {
                    self.multipeerSession?.sendToAllPeers(Data("confirm".utf8))
                }
            }
            
            if anchor.name == "Convex Model ARAnchor" {
                 if modelARAnchor == nil,
                   modelAnchorEntity == nil,
                   stateAnchorEntity == nil,
                   self.collaborationSettingViewModel.collaborationEnabled,
                   self.collaborationSettingViewModel.peerType == .guest {
                    // 同步过来的
                    modelARAnchor = anchor
                    modelAnchorEntity = (self.arView.scene.findEntity(named: "Convex Model AnchorEntity")! as! AnchorEntity)
                    stateAnchorEntity = (self.arView.scene.findEntity(named: "Convex Lab State AnchorEntity")! as! AnchorEntity)
                    
                    self.loadedModel = self.arView.scene.findEntity(named: "Convex_new")!.parent!
                    self.labState = stateAnchorEntity!.children.first! as! ConvexLabStateEntity
                }
                
                entitySubs.append(self.arView.scene.subscribe(to: SynchronizationEvents.OwnershipRequest.self) { event in
                    event.accept()
                    if (event.entity.name == "Board1") {
                        self.arView.scene.synchronizationService?.giveOwnership(of: event.entity.findEntity(named: "VF")!, toPeer: event.requester)
                        self.arView.scene.synchronizationService?.giveOwnership(of: self.loadedModel.findEntity(named: "VF_image")!, toPeer: event.requester)
                    }
                    
                    if (event.entity.name == "Board2") {
                        self.arView.scene.synchronizationService?.giveOwnership(of: event.entity.findEntity(named: "VF_image")!, toPeer: event.requester)
                    }
                })
            }
        }
    }
}

// MARK: - ARCoachingOverlayViewDelegate
extension ConvexLabViewController {
    override func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        for view in allViews {
            view.isHidden = true
        }
//        if let model = self.arView.scene.findEntity(named: "Center") {
//            model.isEnabled = false
//        }
        loadedModel.isEnabled = false
    }
    
    override func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        for view in allViews {
            view.isHidden = false
        }
//        if let model = self.arView.scene.findEntity(named: "Center") {
//            model.isEnabled = true
//        }
        loadedModel.isEnabled = true
    }
}

class DistanceLabelViewModel: ObservableObject, HasDistanceLabelViewInfo {
    @Published var startPoint: CGPoint = CGPoint(x: -100, y: -100)
    @Published var endPoint: CGPoint = CGPoint(x: -200, y: -200)
    @Published var distance: Float = 0
    @Published var focus: Float = 0
    
    func reset() {
        self.startPoint = CGPoint(x: -100, y: -100)
        self.endPoint = CGPoint(x: -200, y: -200)
        self.distance = 0
        self.focus = 0
    }
}

class ConvexLabViewModel: ObservableObject, HasTextModel, HasNumberModel {
    
    @Published var text: String = ""
    var hintMessage = CurrentValueSubject<String, Never>("")
    
    @Published var number: Int = 0
    var accmumulatedRecordNumber = CurrentValueSubject<Int, Never>(0)
    
    @Published var records: [ConvexLabRecord] = []
    
    private var cancelables: [AnyCancellable] = []
    
    func reset() {
//        self.hintMessage.send("")
        self.accmumulatedRecordNumber.send(0)
        self.records = []
//        self.cancelables = []
    }
    
    init() {
        self.cancelables.append(
            hintMessage.sink(receiveValue: { value in
                DispatchQueue.main.async {
                    if value != "" {
                        self.text = value
                    }
                }
            })
        )
        
        self.cancelables.append(
            accmumulatedRecordNumber.sink(receiveValue: { value in
                print("received: \(value)")
                self.number = value
                print("number = \(value)")
            })
        )
    }
    
    struct ConvexLabRecord: Identifiable {
        enum VirtualImageDirection: String {
            case up = "正"
            case down = "倒"
        }
        
        enum VirtualImageScale: String {
            case larger = "放大"
            case smaller = "缩小"
            case almostEqualLarge = "几乎等大"
        }
        
        enum VirtualImageType: String {
            case real = "实像"
            case virtual = "虚像"
        }
        
        static private var _nextID = 0
        static var nextID: Int {
            get {
                _nextID = _nextID + 1
                return _nextID
            }
        }
        
        var id: Int = nextID
        var focusDistance: Float
        var objectDistance: Float
        var virtualImageBoardDistance: Float
        var isInaccurateRecord: Bool
        var virtualImageDirection: VirtualImageDirection
        var virtualImageScale: VirtualImageScale
        var virtualImageType: VirtualImageType
    }
}

extension UIButton {
    func addBlurEffect(style: UIBlurEffect.Style = .light, cornerRadius: CGFloat = 0, padding: CGFloat = 0) {
        backgroundColor = .clear
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        blurView.isUserInteractionEnabled = false
        blurView.backgroundColor = .clear
        if cornerRadius > 0 {
            blurView.layer.cornerRadius = cornerRadius
            blurView.layer.masksToBounds = true
        }
        self.insertSubview(blurView, at: 0)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: padding).isActive = true
        self.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -padding).isActive = true
        self.topAnchor.constraint(equalTo: blurView.topAnchor, constant: padding).isActive = true
        self.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -padding).isActive = true
        
        if let imageView = self.imageView {
            imageView.backgroundColor = .clear
            self.bringSubviewToFront(imageView)
        }
    }
}

enum PeerType: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case host
    case guest
}
