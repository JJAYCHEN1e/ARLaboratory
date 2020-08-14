//
//  ContentView.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/6.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(#colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9607843137, alpha: 0.5)))
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        ScrollView {
                            VStack(alignment: .leading, spacing: 0) {
                                ColumnHeadView(title: "今日推荐", subtitle: "Today", destination: SubjectView())
                                    .padding(.horizontal)
                                RecommandColumn()

                                ColumnHeadView(title: "学科分类", subtitle: "All", destination: SubjectView())
                                    .padding(.horizontal, 24)
                                SubjectColumn()

                                ColumnHeadView(title: "最爱实验", subtitle: "My", destination: SubjectView())
                                    .padding(.horizontal, 24)
                                FavoriteColumn()

                                ColumnHeadView(title: "我的导入", subtitle: "Import", destination: SubjectView())
                                    .padding(.horizontal, 24)
                                FavoriteColumn()
                            }
                        }
                    )
                CardViews(experimentName: "小球碰撞验证动量守恒定律实验")
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
