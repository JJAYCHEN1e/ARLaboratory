//
//  Calculation+Extension.swift
//  ARPlayground
//
//  Created by 陈俊杰 on 2020/10/7.
//

import Foundation
import UIKit

// MARK: - SIMD2

extension SIMD2 where Scalar == Float {
    
    init(startPoint: CGPoint, endPoint: CGPoint){
        self.init(
            x: Scalar(endPoint.x - startPoint.x),
            y: Scalar(endPoint.y - startPoint.y)
        )
    }
    
    init(startPoint: SIMD2<Scalar>, endPoint: SIMD2<Scalar>){
        self.init(
            x: Scalar(endPoint.x - startPoint.x),
            y: Scalar(endPoint.y - startPoint.y)
        )
    }
    
    /// Production of two vector
    static func *(lhs: SIMD2<Scalar>, rhs: SIMD2<Scalar>) -> Scalar{
        lhs.x * rhs.x + lhs.y * rhs.y
    }
    
    /// Magnitude of the vector
    func magnitude() -> Scalar {
        sqrt(x * x + y * y)
    }
    
    static func lerp(start: SIMD2<Scalar>, end: SIMD2<Scalar>, scale: Scalar) -> SIMD2<Scalar>{
        let lineVector = SIMD2(startPoint: start, endPoint: end)
        
        return SIMD2<Scalar>(
            x: Scalar(start.x + scale * lineVector.x),
            y: Scalar(start.y + scale * lineVector.y)
        )
    }
}

// MARK: - SIMD3

extension SIMD3 where Scalar == Float {
    
    init(startPoint: SIMD3<Scalar>, endPoint: SIMD3<Scalar>){
        self.init(
            x: Scalar(endPoint.x - startPoint.x),
            y: Scalar(endPoint.y - startPoint.y),
            z: Scalar(endPoint.z - startPoint.z)
        )
    }
    
    /// Production of two vector
    static func *(lhs: SIMD3<Scalar>, rhs: SIMD3<Scalar>) -> Scalar{
        lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * rhs.z
    }
    
    static func *(lhs: SIMD3<Scalar>, multiplier: Scalar) -> SIMD3<Scalar>{
        SIMD3<Scalar>(
            x: lhs.x * multiplier,
            y: lhs.y * multiplier,
            z: lhs.z * multiplier
        )
    }
    
    static func /(lhs: SIMD3<Scalar>, divider: Scalar) -> SIMD3<Scalar>{
        SIMD3<Scalar>(
            x: lhs.x / divider,
            y: lhs.y / divider,
            z: lhs.z / divider
        )
    }
    
    /// Magnitude of the vector
    func magnitude() -> Scalar {
        sqrt(x * x + y * y + z * z)
    }
    
    func unit() -> SIMD3<Scalar>{
        return self / self.magnitude()
    }
    
    static func lerp(start: SIMD3<Scalar>, end: SIMD3<Scalar>, scale: Scalar) -> SIMD3<Scalar>{
        let lineVector = SIMD3(startPoint: start, endPoint: end)
        
        return SIMD3<Scalar>(
            x: Scalar(start.x + scale * lineVector.x),
            y: Scalar(start.y + scale * lineVector.y),
            z: Scalar(start.z + scale * lineVector.z)
        )
    }
}
