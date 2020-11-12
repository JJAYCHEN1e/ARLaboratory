//
//  LeftPopoverWithArrowModifier.swift
//  ceshi2
//
//  Created by 陈俊杰 on 11/6/20.
//
import SwiftUI
import UIKit

fileprivate struct LeftPopoverWithArrowModifier: ViewModifier {
    @State var text: String
    @State var triggered = false
    
    func body(content: Content) -> some View {
        content
            .overlay (
                GeometryReader { geometry in
                    HStack(spacing: 0) {
                        Text(text)
                            .padding()
                            .foregroundColor(Color.white.opacity(0.8))
                            .font(.headline)
                            .background(
                                Blur(style: .systemThinMaterial)
                            )
                            .frame(width: 50)
                            .cornerRadius(15)
                        Color.clear
                            .background(
                                Blur(style: .systemThinMaterial)
                            )
                            .frame(width: 20, height: 30)
                            .clipShape(LeftPopoverWithArrowShape())
                    }
                    .fixedSize(horizontal: false, vertical: true)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    .offset(x: -(geometry.size.width / 2 + 40))
                }
                .opacity(triggered ? 1 : 0)
                .animation(.easeInOut)
            )
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    triggered = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        triggered = false
                    }
                }
            }
            .environment(\.colorScheme, .dark)
    }
    
    struct LeftPopoverWithArrowShape: Shape {
        func path(in rect: CGRect) -> Path {
            let centerY = rect.height / 2
            
            return Path { path in
                path.move(to: CGPoint(x: 0, y: centerY - 15))
                
                path.addLine(to: CGPoint(x: 20, y: centerY))
                path.addLine(to: CGPoint(x: 0, y: centerY + 15))
            }
        }
    }
}

extension View {
    func leftPopoverWithArrow(text: String) -> some View {
        self.modifier(LeftPopoverWithArrowModifier(text: text))
    }
}
