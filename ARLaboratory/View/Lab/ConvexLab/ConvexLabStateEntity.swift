//
//  ConvexLabStateEntity.swift
//  ceshi2
//
//  Created by 陈俊杰 on 11/9/20.
//

import Foundation
import RealityKit
import Combine

public struct ConvexLabStateComponent: Component {
    var readyToPlace = false
    var modelPlaced = false
    var confirmed = false
}

extension ConvexLabStateComponent: Codable {}

public protocol HasConvexLabState where Self: Entity {}

extension HasConvexLabState where Self: Entity {

    public var convexLabState: ConvexLabStateComponent {
        get { return components[ConvexLabStateComponent.self] ?? ConvexLabStateComponent() }
        set { components[ConvexLabStateComponent.self] = newValue }
    }

    var readyToPlace: Bool {
        get {
            self.convexLabState.readyToPlace
        }
        set {
            self.convexLabState.readyToPlace = newValue
        }
    }
    
    var modelPlaced: Bool {
        get {
            self.convexLabState.modelPlaced
        }
        set {
            self.convexLabState.modelPlaced = newValue
        }
    }
    
    var confirmed: Bool {
        get {
            self.convexLabState.confirmed
        }
        set {
            self.convexLabState.confirmed = newValue
        }
    }
}

class ConvexLabStateEntity: Entity, HasConvexLabState {
    required init() {
        super.init()
        self.convexLabState = ConvexLabStateComponent()
    }
}


////
////  ConvexLabStateEntity.swift
////  ceshi2
////
////  Created by 陈俊杰 on 11/9/20.
////
//
//import Foundation
//import RealityKit
//import Combine
//
//public struct ConvexLabStateComponent: Component, Codable {
//    var readyToPlace = CurrentValueSubject<Bool, Never>(false)
//    var modelPlaced = CurrentValueSubject<Bool, Never>(false)
//    var confirmed = CurrentValueSubject<Bool, Never>(false)
//}
//
//public protocol HasConvexLabState where Self: Entity {}
//
//extension HasConvexLabState where Self: Entity {
//
//    public var convexLabState: ConvexLabStateComponent {
//        get { return components[ConvexLabStateComponent.self] ?? ConvexLabStateComponent() }
//        set { components[ConvexLabStateComponent.self] = newValue }
//    }
//
//    var readyToPlace: Bool {
//        get {
//            self.convexLabState.readyToPlace.value
//        }
//        set {
//            self.convexLabState.readyToPlace.send(newValue)
//        }
//    }
//    
//    var modelPlaced: Bool {
//        get {
//            self.convexLabState.modelPlaced.value
//        }
//        set {
//            self.convexLabState.modelPlaced.send(newValue)
//        }
//    }
//    
//    var confirmed: Bool {
//        get {
//            self.convexLabState.confirmed.value
//        }
//        set {
//            self.convexLabState.confirmed.send(newValue)
//        }
//    }
//}
//
//class ConvexLabStateEntity: Entity, HasConvexLabState {
//    required init() {
//        super.init()
//        self.convexLabState = ConvexLabStateComponent()
//    }
//}
