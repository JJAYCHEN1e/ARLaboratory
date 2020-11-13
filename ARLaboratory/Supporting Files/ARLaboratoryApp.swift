//
//  ARLaboratoryApp.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/6.
//

import SwiftUI
import NavigationStack
@main
struct ARLaboratoryApp: App {
    @EnvironmentObject private var navigationStack: NavigationStack
    @ObservedObject var globalExperiments = GlobalExperiments()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            NavigationStackView(){
                
                MainHomePageView()
                
            }.edgesIgnoringSafeArea(.all)
            .statusBar(hidden: true)
        }
    }
    
    
}
class ViewModel: ObservableObject {
    @Published var selection: Int = 2
    @Published var showAlert: Bool = false
    @Published var alert = Alert(title: Text("提示"), message: Text("程序员小哥哥正在加急制作这个功能，敬请期待哦～"), dismissButton: .default(Text("Got it!")))

}
