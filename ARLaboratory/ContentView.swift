//
//  ContentView.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/6.
//

import SwiftUI

struct ContentView: View {
    @State private var flag = false
    @State private var show = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(#colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9607843137, alpha: 0.5)))
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ColumnHeadView(title: "今日推荐", subtitle: "Today")
                            .padding(.horizontal)
                            .onTapGesture(count: 1, perform: {
                                withAnimation(.spring(), { flag.toggle() })
                            })
                        RecommandColumn()
                        
                        
                        NavigationLink(
                            destination: SubjectView(show: $show)
                                .navigationBarHidden(true),
                            isActive: $show,
                            label: {
                                ColumnHeadView(title: "学科分类", subtitle: "All")
                                    .padding(.horizontal, 24)
                            })
                            .navigationBarHidden(true)
                        SubjectColumn()
                        
                        ColumnHeadView(title: "最爱实验", subtitle: "My")
                            .padding(.horizontal, 24)
                        FavoriteColumn()
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
