//
//  ContentView.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/6.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ColumnHeadView(title: "今日推荐", subtitle: "Today")
                    .padding(.horizontal, 24)
                    .padding(.vertical)
                RecommandColumn()
                
                ColumnHeadView(title: "学科分类", subtitle: "All")
                    .padding(.horizontal, 24)
                    .padding(.vertical)
                RecommandColumn()
                
                ColumnHeadView(title: "最爱实验", subtitle: "My")
                    .padding(.horizontal, 24)
                    .padding(.vertical)
                RecommandColumn()
            }
            .ignoresSafeArea()
            .background(Color(#colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9607843137, alpha: 0.5)))
            .padding(.vertical)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
