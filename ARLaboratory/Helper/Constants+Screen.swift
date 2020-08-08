//
//  Constants+Screen.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/8.
//

import Foundation
import UIKit

var screenSize: CGSize {
    get{ UIScreen.main.bounds.size }
}

var screenWidth: CGFloat {
    get { screenSize.width }
}

var screenHeight: CGFloat {
    get { screenSize.height }
}
