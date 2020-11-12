//
//  CautionCircleModifier.swift
//  ceshi2
//
//  Created by 陈俊杰 on 11/7/20.
//

import SwiftUI


protocol HasNumberModel: ObservableObject {
    var number: Int { get set }
}

fileprivate struct CautionCircleModifier<Model: HasNumberModel>: ViewModifier {
    @ObservedObject var numberModel: Model
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.red)
                    .overlay(
                        Text("\(numberModel.number)")
                            .foregroundColor(.white)
                    )
                    .offset(x: 10.0, y: -10.0)
                    .opacity(numberModel.number > 0 ? 1 : 0)
                , alignment: .topTrailing
            )
    }
}

extension View {
    func cautionCircle<Model: HasNumberModel>(numberModel: Model) -> some View {
        self.modifier(CautionCircleModifier(numberModel: numberModel))
    }
}

