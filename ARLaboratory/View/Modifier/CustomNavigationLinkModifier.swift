//
//  CustomNavigationLink.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/11.
//

import SwiftUI

//fileprivate struct CustomNavigationLinkModifier<DestinationContent: View>: ViewModifier {
//    @State private var isActive = false
//    
//    var destination: DestinationContent
//    
//    func body(content: Content) -> some View {
//        NavigationLink(
//            destination:
//                destination
//                .overlay(
//                    Circle()
//                        .frame(width: 44, height: 44)
//                        .padding()
//                        .overlay(
//                            Image(systemName: "arrow.backward")
//                                .foregroundColor(.primaryColor)
//                                .onTapGesture {
//                                    isActive = false
//                                }
//                        ),
//                    alignment: .topLeading)
//                .navigationBarHidden(true),
//            isActive: $isActive,
//            label: {
//                content
//            })
//    }
//}
//
//extension View {
//    func customNavigationLink<DestinationContent: View>(destination: DestinationContent) -> some View{
//        self.modifier(CustomNavigationLinkModifier(destination: destination))
//    }
//}
