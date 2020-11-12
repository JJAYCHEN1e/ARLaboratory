//
//  ARButton.swift
//  ceshi2
//
//  Created by 陈俊杰 on 11/5/20.
//

import SwiftUI

struct ARButtonWithBlurBackground: View {
    @State var systemName: String
    @State var fontSize: CGFloat = 20
    @State var action: () -> Void
    @State var blurEffect: UIBlurEffect.Style?
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: systemName)
                .foregroundColor(.primary)
                .font(.system(size: fontSize))
//                .padding(.horizontal, 30)
//                .padding(.vertical, 12)
                .frame(minWidth: 80, minHeight: 45)
                .background(
                    Blur(style: blurEffect ?? .systemThinMaterialDark)
                        .opacity(0.9)
                )
                .cornerRadius(15)
        }
    }
}

struct ARButtonWithPureBackground: View {
    @State var systemName: String
    @State var fontSize: CGFloat = 40
    @State var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: systemName)
                .foregroundColor(.white)
                .font(.system(size: fontSize))
        }
    }
}

