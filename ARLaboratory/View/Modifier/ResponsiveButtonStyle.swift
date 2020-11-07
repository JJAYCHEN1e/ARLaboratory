//
//  ResponsiveButtonStyle.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/9.
//

import UIKit
import SwiftUI

struct ResponsiveButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95: 1)
            .animation(.spring())
    }
}

fileprivate struct NavigationLinkWithResponsiveButtonStyleModifier<Destination: View>: ViewModifier {
    var destination: Destination
    func body(content: Content) -> some View {
        NavigationLink(destination: destination) {
            content
        }
        .buttonStyle(ResponsiveButtonStyle())
    }
}

extension View {
    func navigationLinkWithResponsiveButtonStype<Destination: View>(desination: Destination) -> some View {
        self.modifier(NavigationLinkWithResponsiveButtonStyleModifier(destination: desination))
    }
}
