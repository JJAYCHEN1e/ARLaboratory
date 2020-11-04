//
//  MainHomePageView.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/11/3.
//

import SwiftUI

struct MainHomePageView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            HomepageHeaderView().ignoresSafeArea()
            ZStack {
                RoundedRectangle(cornerRadius: 22).ignoresSafeArea().foregroundColor(.white)
                    .ignoresSafeArea()
                    .offset(y: -43)
                    .overlay(MainHomepageContentView())
            }
            
            
        }
    }
}

struct MainHomePageView_Previews: PreviewProvider {
    static var previews: some View {
        MainHomePageView()
    }
}
