//
//  UINavigationController+Swipe.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/11.
//

import UIKit

/// Allow swipe back gesture when use .navigationBarHidden(true)
/// Reference:
/// https://stackoverflow.com/questions/59921239/hide-navigation-bar-without-losing-swipe-back-gesture-in-swiftui
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
