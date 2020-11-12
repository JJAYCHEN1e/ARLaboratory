//
//  ARLabViewController.swift
//  ARPlayground
//
//  Created by 陈俊杰 on 10/29/20.
//

import UIKit
import RealityKit
import ARKit
import MultipeerConnectivity

class ARLabViewController: UIViewController {
    var arView: ARView!
    
    private(set) var serviceType: String?
    private(set) var multipeerSession: MultipeerSession?
    var peerName = [MCPeerID: String]()
    
    let coachingOverlay = ARCoachingOverlayView()
    
    convenience init(serviceType: String?) {
        self.init(nibName: nil, bundle: nil)
        
        self.serviceType = serviceType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        
        let arView = ARView(frame: .zero)
        self.arView = arView
        arView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(arView)
        
        NSLayoutConstraint.activate([
            arView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            arView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            arView.widthAnchor.constraint(equalTo: view.widthAnchor),
            arView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        setupCoachingOverlay()
        
        arView.automaticallyConfigureSession = false
        arView.environment.sceneUnderstanding.options.insert(.occlusion)
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        config.isCollaborationEnabled = true
//        config.frameSemantics = [.personSegmentationWithDepth]
        config.environmentTexturing = .automatic
        
        arView.session.run(config)
    }
    
    func resetTracking() {
        guard let configuration = arView.session.configuration else {
            print("A configuration is required"); return
            
        }
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func setupMultipeerSession(serviceType: String,
                               peerType: PeerType,
                               receivedDataHandler: ((Data, MCPeerID) -> Void)? = nil,
                               peerJoinedHandler: ((MCPeerID) -> Void)? = nil,
                               peerLeftHandler: ((MCPeerID) -> Void)? = nil,
                               peerDiscoveredHandler: ((MCPeerID, [String: String]?) -> Bool)? = nil,
                               peerInvitationdHandler: ((MCPeerID, [String: String]?) -> Bool)? = nil) {
        multipeerSession = MultipeerSession(
            serviceType: serviceType,
            peerType: peerType,
            receivedDataHandler: receivedDataHandler,
            peerJoinedHandler: peerJoinedHandler,
            peerLeftHandler: peerLeftHandler,
            peerDiscoveredHandler: peerDiscoveredHandler,
            peerInvitationdHandler: peerInvitationdHandler)
        arView.scene.synchronizationService = try! MultipeerConnectivityService(session: multipeerSession!.session)
    }
    
    func unsetupMultipeerSession() {
        arView.scene.synchronizationService = nil
    }
}

extension ARLabViewController: ARCoachingOverlayViewDelegate {
    
    func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        
    }
    
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        
    }
    
    func coachingOverlayViewDidRequestSessionReset(_ coachingOverlayView: ARCoachingOverlayView) {
        resetTracking()
    }
    
    func setupCoachingOverlay() {
        // Set up coaching view
        coachingOverlay.session = arView.session
        coachingOverlay.delegate = self
        coachingOverlay.goal = .tracking
        coachingOverlay.activatesAutomatically = true
        
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        arView.addSubview(coachingOverlay)
        
        NSLayoutConstraint.activate([
            coachingOverlay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coachingOverlay.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            coachingOverlay.widthAnchor.constraint(equalTo: view.widthAnchor),
            coachingOverlay.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
}
