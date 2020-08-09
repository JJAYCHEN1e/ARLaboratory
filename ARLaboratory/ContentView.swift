//
//  ContentView.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/6.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Rectangle()
            .foregroundColor(Color(#colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9607843137, alpha: 0.5)))
            .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading) {
                    ColumnHeadView(title: "今日推荐", subtitle: "Today")
                        .padding(.horizontal)
                        .padding(.vertical)
                    RecommandColumn()
                    
                    ColumnHeadView(title: "学科分类", subtitle: "All")
                        .padding(.horizontal, 24)
                        .padding(.vertical)
                    SubjectColumn()
                    
                    ColumnHeadView(title: "最爱实验", subtitle: "My")
                        .padding(.horizontal, 24)
                        .padding(.vertical)
                    RecommandColumn()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
