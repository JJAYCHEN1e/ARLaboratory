//
//  ContentView.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/6.
//

import SwiftUI

struct ContentView: View {
    @State private var onAppearAnimation = true
    
    var body: some View {
        NavigationView {
            Rectangle()
                .foregroundColor(Color(#colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9607843137, alpha: 0.5)))
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 0) {
                            Group {
                                ColumnHeadView(title: "今日推荐", subtitle: "Today", destination: SubjectView())
                                    .padding(.horizontal)
                                RecommandColumn()
                            }
                            .opacity(onAppearAnimation ? 0 : 1)
                            .offset(y: onAppearAnimation ? 100 : 0)
                            .animation(Animation.easeInOut(duration: 1).delay(0))
                            
                            Group {
                                ColumnHeadView(title: "学科分类", subtitle: "All", destination: SubjectView())
                                    .padding(.horizontal, 24)
                                SubjectColumn()
                            }
                            .opacity(onAppearAnimation ? 0 : 1)
                            .offset(y: onAppearAnimation ? 80 : 0)
                            .animation(Animation.easeInOut(duration: 0.7).delay(0.3))
                            
                            Group {
                                ColumnHeadView(title: "最爱实验", subtitle: "My", destination: SubjectView())
                                    .padding(.horizontal, 24)
                                FavoriteColumn()
                                
                                ColumnHeadView(title: "我的导入", subtitle: "Import", destination: EmptyView())
                                    .padding(.horizontal, 24)
                            }
                            .opacity(onAppearAnimation ? 0 : 1)
                            .offset(y: onAppearAnimation ? 60 : 0)
                            .animation(Animation.easeInOut(duration: 0.7).delay(0.6))
                            
                            Group {
                                ColumnHeadView(title: "我的导入", subtitle: "Import", destination: SubjectView())
                                    .padding(.horizontal, 24)
                                ImportColumn()
                            }
                            .opacity(onAppearAnimation ? 0 : 1)
                            .offset(y: onAppearAnimation ? 40 : 0)
                            .animation(Animation.easeInOut(duration: 0.7).delay(0.8))
                        }
                        .onAppear {
                            DispatchQueue.global().async {
                                onAppearAnimation = false
                            }
                        }
                    }
                )
                .navigationTitle("首页")
                .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
