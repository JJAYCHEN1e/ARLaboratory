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
        }
    }
    
    
}
class ViewModel: ObservableObject {
    @Published var selection: Int = 2
}
