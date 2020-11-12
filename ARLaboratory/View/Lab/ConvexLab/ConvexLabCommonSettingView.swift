//
//  ConvexLabCommonSettingView.swift
//  ceshi2
//
//  Created by 陈俊杰 on 11/7/20.
//

import SwiftUI
import Combine

class ConvexLabCommonSettingViewModel: ObservableObject {
    @Published var showRealVirtualImage = true
    @Published var showFocusPoint = true
    @Published var showDistanceLabels = true
    @Published var showLenFocusLabel = false
    @Published var showObjectDistanceLabel = true
    @Published var showVirtualImageDistanceLabel = true
    
    var cancellables: [Cancellable] = []
}

struct ConvexLabCommonSettingView: View {
    @ObservedObject var model = ConvexLabCommonSettingViewModel()
    
    var body: some View {
        VStack {
            Label("Setting", systemImage: "gearshape")
                .font(.title)
            
            Form {
                Section(header: Text("Real Virtual Image Visualization")) {
                    Toggle(isOn: $model.showRealVirtualImage) {
                        Text("Show Real Virtual Image")
                    }
                }
                
                Group {
                    Section(header: Text("Distance Visualization")) {
                        Toggle(isOn: $model.showDistanceLabels) {
                            Text("Show Distance Labels")
                        }
                        Group {
                            Toggle(isOn: $model.showObjectDistanceLabel) {
                                Text("Show Object Distance")
                                    .foregroundColor(model.showDistanceLabels ? .primary : .gray)
                            }
                            Toggle(isOn: $model.showVirtualImageDistanceLabel) {
                                Text("Show Virtual Image Distance")
                                    .foregroundColor(model.showDistanceLabels ? .primary : .gray)
                            }
                            Toggle(isOn: $model.showLenFocusLabel) {
                                Text("Show Len Focus Distance")
                                    .foregroundColor(model.showDistanceLabels ? .primary : .gray)
                            }
                        }
                        .disabled(!model.showDistanceLabels)
                    }
                }
                
                Section(header: Text("Focus Point Visualization")) {
                    Toggle(isOn: $model.showFocusPoint) {
                        Text("Show Focus Point")
                    }
                }
            }
            .onAppear() {
                UITableView.appearance().backgroundColor = .clear
            }
            .onDisappear() {
                UITableView.appearance().backgroundColor = .systemBackground
            }
        }
        .padding()
        .foregroundColor(.primary)
        .background(
            Blur(style: .systemThinMaterial)
        )
        .cornerRadius(50)
        .frame(width: 400, height: 350)
        .environment(\.colorScheme, .dark)
    }
}
