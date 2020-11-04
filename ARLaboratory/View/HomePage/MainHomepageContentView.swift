//
//  MainHomepageContentView.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/11/3.
//

import SwiftUI

struct MainHomepageContentView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                VStack {
                    SubtitleComponent(str: "常用功能")
                    HStack {
                        
                        Image("history").resizable().aspectRatio(contentMode: .fit).frame(width: 225, height: 95).overlay(
                            HStack {
                                Spacer()
                                VStack(alignment: .trailing){
                                    Spacer()
                                    Text("学习记录").font(Font.system(size: 15).weight(.bold)).foregroundColor(Color(#colorLiteral(red: 0.9607843137, green: 0.9529411765, blue: 0.9529411765, alpha: 1))).kerning(1)
                                    Text("2020-10-23").font(Font.system(size: 12).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.8862745098, green: 0.8862745098, blue: 0.8862745098, alpha: 1))).kerning(0)
                                }
                            }.padding(.trailing,15).padding(.bottom,14)
                        )
                        Spacer()
                        Image("collection").resizable().aspectRatio(contentMode: .fit).frame(width: 225, height: 95).overlay(
                            HStack {
                                Spacer()
                                VStack(alignment: .trailing){
                                    Spacer()
                                    Text("我的收藏").font(Font.system(size: 15).weight(.bold)).foregroundColor(Color(#colorLiteral(red: 0.9607843137, green: 0.9529411765, blue: 0.9529411765, alpha: 1))).kerning(1)
                                    Text("尚未收藏").font(Font.system(size: 12).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.8862745098, green: 0.8862745098, blue: 0.8862745098, alpha: 1))).kerning(0)
                                }
                            }.padding(.trailing,15).padding(.bottom,14)
                        )
                        Spacer()
                        Image("group").resizable().aspectRatio(contentMode: .fit).frame(width: 225, height: 95).overlay(
                            HStack {
                                Spacer()
                                VStack(alignment: .trailing){
                                    Spacer()
                                    Text("实验群组").font(Font.system(size: 15).weight(.bold)).foregroundColor(Color(#colorLiteral(red: 0.9607843137, green: 0.9529411765, blue: 0.9529411765, alpha: 1))).kerning(1)
                                    Text("快来参加叭！").font(Font.system(size: 12).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.8862745098, green: 0.8862745098, blue: 0.8862745098, alpha: 1))).kerning(0)
                                }
                            }.padding(.trailing,15).padding(.bottom,14)
                        )
                    }
                }.padding(.horizontal,53).padding(.bottom,10)
                
                
                SubtitleComponent(str: "推荐实验").padding(.horizontal,53).padding(.vertical,10).padding(.top,10)
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false)
                {
                    HStack(alignment: .top,spacing: 0){
                        
                        LazyVStack{
                            ExperimentCardView(showBottom: true, liked: false, showArrow: true)
                            ExperimentCardView(showBottom: true, liked: false, showArrow: true)
                            ExperimentCardView(showBottom: false, liked: false, showArrow: true)
                            ExperimentCardView(showBottom: false, liked: false, showArrow: true)
                            Spacer()
                        }
                        Spacer()
                        LazyVStack{
                            ExperimentCardView(showBottom: false, liked: false, showArrow: true)
                            ExperimentCardView(showBottom: false, liked: false, showArrow: true)
                            ExperimentCardView(showBottom: true, liked: false, showArrow: true)
                            ExperimentCardView(showBottom: true, liked: false, showArrow: true)
                            Spacer()
                        }
                        Spacer()
                        LazyVStack{
                            ExperimentCardView(showBottom: true, liked: false, showArrow: true)
                            ExperimentCardView(showBottom: false, liked: false, showArrow: true)
                            ExperimentCardView(showBottom: true, liked: false, showArrow: true)
                            ExperimentCardView(showBottom: false, liked: false, showArrow: true)
                            Spacer()
                        }
                        
                    }.padding(.horizontal, 44).padding(.bottom,70)
                }
            }
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 35)
                    .frame(width: 290, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.white)
                    .shadow(color: Color(#colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 0.11)), radius: 4, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    .shadow(color: Color(#colorLiteral(red: 0.8117647059, green: 0.8117647059, blue: 0.8117647059, alpha: 1)), radius: 20, x: 0, y: 10)
                    .overlay( HStack {
                        Rectangle()
                            .frame(width: 31, height: 31, alignment: .center)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .mask(Image("StorePage").resizable().frame(width: 31, height: 31, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/))
                        Spacer()
                        Rectangle()
                            .frame(width: 31, height: 31, alignment: .center)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .mask(Image("HomePage").resizable().frame(width: 31, height: 31, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/))
                        Spacer()
                        Rectangle()
                            .frame(width: 31, height: 31, alignment: .center)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .mask(Image("AccountPage").resizable().frame(width: 31, height: 31, alignment: .center))
                    }.padding(.horizontal,40)
                    )
            }
        }
    }
}

struct MainHomepageContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainHomepageContentView()
    }
}


