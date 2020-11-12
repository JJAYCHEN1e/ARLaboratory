//
//  TopLeftPopoverWithArrowModifier.swift
//  ceshi2
//
//  Created by 陈俊杰 on 11/7/20.
//

import SwiftUI

struct TopLeftPopoverWithArrowModifier: ViewModifier {
    @State var text: String
    @State var triggered = false
    
    func body(content: Content) -> some View {
        content
            .overlay (
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        Text(text)
                            .padding()
                            .foregroundColor(Color.white.opacity(0.8))
                            .font(.headline)
                            .background(
                                Blur(style: .systemThinMaterial)
                            )
                            .frame(height: 50)
                            .cornerRadius(15)
                        Color.clear
                            .background(
                                Blur(style: .systemThinMaterial)
                            )
                            .frame(height: 20)
                            .frame(maxWidth: .infinity)
                            .clipShape(TopLeftPopoverWithArrowShape())
                    }
                    .fixedSize(horizontal: true, vertical: false)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    .offset(x: -(geometry.size.width / 2), y: -(geometry.size.height / 2 + 40))
                    .environment(\.colorScheme, .dark)
                }
                .opacity(triggered ? 1 : 0)
                .animation(.easeInOut)
            )
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    triggered = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                        triggered = false
                    }
                }
            }
    }
    
    struct TopLeftPopoverWithArrowShape: Shape {
        func path(in rect: CGRect) -> Path {
            let centerX = rect.width / 3 * 2
            
            return Path { path in
                path.move(to: CGPoint(x: centerX - 15, y: 0))
                
                path.addLine(to: CGPoint(x: centerX, y: 20))
                path.addLine(to: CGPoint(x: centerX + 15, y: 0))
            }
        }
    }
}

extension View {
    func topLeftPopoverWithArrow(text: String) -> some View {
        self.modifier(TopLeftPopoverWithArrowModifier(text: text))
    }
}


