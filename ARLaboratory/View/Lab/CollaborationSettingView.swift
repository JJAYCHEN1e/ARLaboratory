//
//  CollaborationSettingView.swift
//  ceshi2
//
//  Created by 陈俊杰 on 11/5/20.
//

import SwiftUI

class CollaborationSettingViewModel: ObservableObject {
    @Published var collaborationEnabled = false
    @Published var username: String = UIDevice.current.name
    @Published var peerType: PeerType = .host
}

struct CollaborationSettingView: View {
    
    @ObservedObject var model: CollaborationSettingViewModel
    
    var body: some View {
        VStack {
            Label("Collaboration", systemImage: "person.2")
                .font(.title)
            
            Form {
                Section(header: Text("")) {
                    Toggle(isOn: $model.collaborationEnabled) {
                        Text("Enable Collaboration")
                    }
                }
                
                Group {
                    Section(header: Text("PROFILE").foregroundColor(model.collaborationEnabled ? .primary : .gray)) {
                        HStack {
                            Text("Username")
                                .foregroundColor(model.collaborationEnabled ? .primary : .gray)
                            Spacer()
                            TextField("Your Username", text: $model.username)
                                .foregroundColor(model.collaborationEnabled ? .primary : .gray)
                                .frame(maxWidth: 200)
                        }
                        
                        HStack {
                            Text("Peer Type")
                                .foregroundColor(model.collaborationEnabled ? .primary : .gray)
                            Spacer()
                            Picker("Peer Type", selection: $model.peerType) {
                                ForEach(PeerType.allCases) { peerType in
                                    Text(peerType.rawValue.capitalized).tag(peerType)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .frame(maxWidth: 200)
                        }
                    }
                }
                .disabled(!model.collaborationEnabled)
            }
            .onAppear() {
                UITableView.appearance().backgroundColor = .clear
//                UITableViewCell.appearance().backgroundColor = UIColor.systemBackground.withAlphaComponent(0.8)
//                UITextField.appearance().backgroundColor = .clear
            }
            .onDisappear() {
                UITableView.appearance().backgroundColor = .systemBackground
//                UITableViewCell.appearance().backgroundColor = .systemBackground
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

//struct CollaborationSettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        CollaborationSettingView()
//    }
//}
