//
//  ResponsiveButton.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/9.
//

import UIKit
import SwiftUI

fileprivate class CustomResponsiveButton: UIView {
    
    var delegate: CustomResponsiveButtonDelegate
    
    init(delegate: CustomResponsiveButtonDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate.isPressing()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        delegate.endPessing()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate.endPessing()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate.endPessing()
        if let view = hitTest(touches.first!.location(in: self), with: nil), view == self {
            delegate.tapped()
        }
    }
}

fileprivate protocol CustomResponsiveButtonDelegate {
    func isPressing()
    
    func endPessing()
    
    func tapped()
}

fileprivate struct CustomButtonView: UIViewRepresentable {
    @Binding var pressing: Bool
    var action: (() -> ())?
    
    typealias UIViewType = CustomResponsiveButton
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: CustomResponsiveButtonDelegate {
        func isPressing() {
            parent.pressing = true
        }
        
        func endPessing() {
            parent.pressing = false
        }
        
        func tapped() {
            parent.action?()
        }
        
        let parent: CustomButtonView
        init(_ customButtonView: CustomButtonView) {
            self.parent = customButtonView
        }
    }
    
    func makeUIView(context: Context) -> CustomResponsiveButton {
        return CustomResponsiveButton(delegate: context.coordinator)
    }
    
    func updateUIView(_ uiView: CustomResponsiveButton, context: Context) {
        return
    }
}

fileprivate struct ResponsiveButtonModifier: ViewModifier {
    @State private var pressing: Bool = false
    
    let action: (() -> ())?
    
    init(action: (() -> ())? = nil) {
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                CustomButtonView(pressing: $pressing, action: action)
            )
            .scaleEffect(pressing ? 0.95 : 1)
            .animation(.spring())
    }
}

extension View {
    func responsiveButton(action: (() -> ())?) -> some View {
        self.modifier(ResponsiveButtonModifier(action: action))
    }
}
