//
//  Constants.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/8.
//

import Foundation
import SwiftUI

extension Color {
    static let primaryColor = Color("primaryColor")
    static let secondaryColor = Color("secondaryColor")
    
    static func from(hexString: String) -> Color {
        Color.init(UIColor(fromHexString: hexString))
    }
}
