//
//  MainHomepageContentView.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/11/3.
//

import SwiftUI

struct MainHomepageContentView: View {
    var body: some View {
            VStack(spacing: 0) {
                
                VStack {
                    SubtitleComponent(str: "常用功能").padding(.bottom,10)
                    HStack {
                        
                        Button(action: {}) {
                            Image("history").resizable().aspectRatio(contentMode: .fit)
                                .frame(width: 225, height: 95)
                                .shadow(color: Color(#colorLiteral(red: 0.8352941176, green: 0.831372549, blue: 1, alpha: 1)), radius: 15, x: 2, y: 2).overlay(
                                    HStack {
                                        HStack {
                                        Spacer()
                                        VStack(alignment: .trailing){
                                            Spacer()
                                            Text("学习记录").font(Font.system(size: 15).weight(.bold)).foregroundColor(Color(#colorLiteral(red: 0.9607843137, green: 0.9529411765, blue: 0.9529411765, alpha: 1))).kerning(1)
                                            Text("2020-10-23").font(Font.system(size: 12).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.8862745098, green: 0.8862745098, blue: 0.8862745098, alpha: 1))).kerning(0)
                                        }
                                        }.padding(.trailing,15).padding(.bottom,14)
                                    }
                            )
                        }.buttonStyle(ResponsiveButtonStyle())
                        Spacer()
                        
                        
                        
                        Button(action:{}) {
                            Image("collection").resizable().aspectRatio(contentMode: .fit)
                                .frame(width: 225, height: 95)
                                .shadow(color: Color(#colorLiteral(red: 0.8274509804, green: 0.8862745098, blue: 0.9333333333, alpha: 1)), radius: 15, x: 2, y: 2)
                                .overlay(
                                HStack {
                                    Spacer()
                                    VStack(alignment: .trailing){
                                        Spacer()
                                        Text("我的收藏").font(Font.system(size: 15).weight(.bold)).foregroundColor(Color(#colorLiteral(red: 0.9607843137, green: 0.9529411765, blue: 0.9529411765, alpha: 1))).kerning(1)
                                        Text("尚未收藏").font(Font.system(size: 12).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.8862745098, green: 0.8862745098, blue: 0.8862745098, alpha: 1))).kerning(0)
                                    }
                                }.padding(.trailing,15).padding(.bottom,14)
                            )
                        }.buttonStyle(ResponsiveButtonStyle())
                        Spacer()
                        Button(action: {}) {
                            Image("group").resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 225, height: 95)
                                .shadow(color: Color(#colorLiteral(red: 0.8235294118, green: 0.9137254902, blue: 0.9137254902, alpha: 1)), radius: 15, x: 2, y: 2)
                                .overlay(
                                HStack {
                                    Spacer()
                                    VStack(alignment: .trailing){
                                        Spacer()
                                        Text("实验群组").font(Font.system(size: 15).weight(.bold)).foregroundColor(Color(#colorLiteral(red: 0.9607843137, green: 0.9529411765, blue: 0.9529411765, alpha: 1))).kerning(1)
                                        Text("快来参加叭！").font(Font.system(size: 12).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.8862745098, green: 0.8862745098, blue: 0.8862745098, alpha: 1))).kerning(0)
                                    }
                                }.padding(.trailing,15).padding(.bottom,14)
                            )
                        }.buttonStyle(ResponsiveButtonStyle())
                    }
                }.padding(.horizontal,53).padding(.bottom,10)
                
                
                SubtitleComponent(str: "推荐实验").padding(.horizontal,53).padding(.vertical,10).padding(.top,10)
                    HStack(alignment: .top,spacing: 0){
                        
                        LazyVStack{
                            ExperimentCardView(title: "气体的制备", subject: "生物", chapter: 1, image: "化学实验图例", column: "", numbersOfProblems: 1, numbersOfCorrectAnswers: 8, score: 79, showBottom: true, liked: false, showArrow: true)
                            ExperimentCardView(title: "气体的制备", subject: "生物", chapter: 1, image: "化学实验图例", column: "", numbersOfProblems: 1, numbersOfCorrectAnswers: 8, score: 79, showBottom: true, liked: false, showArrow: true)
                            ExperimentCardView(title: "气体的制备", subject: "生物", chapter: 1, image: "化学实验图例", column: "", numbersOfProblems: 1, numbersOfCorrectAnswers: 8, score: 79, showBottom: true, liked: false, showArrow: true)
                            Spacer()
                        }
                        Spacer()
                        LazyVStack{
                            ExperimentCardView(title: "气体的制备", subject: "生物", chapter: 1, image: "化学实验图例", column: "", numbersOfProblems: 1, numbersOfCorrectAnswers: 8, score: 79, showBottom: true, liked: false, showArrow: true)
                            ExperimentCardView(title: "气体的制备", subject: "生物", chapter: 1, image: "化学实验图例", column: "", numbersOfProblems: 1, numbersOfCorrectAnswers: 8, score: 79, showBottom: true, liked: false, showArrow: true)
                            ExperimentCardView(title: "气体的制备", subject: "生物", chapter: 1, image: "化学实验图例", column: "", numbersOfProblems: 1, numbersOfCorrectAnswers: 8, score: 79, showBottom: true, liked: false, showArrow: true)
                            
                            Spacer()
                        }
                        Spacer()
                        LazyVStack{
                            ExperimentCardView(title: "气体的制备", subject: "生物", chapter: 1, image: "化学实验图例", column: "", numbersOfProblems: 1, numbersOfCorrectAnswers: 8, score: 79, showBottom: true, liked: false, showArrow: true)
                            ExperimentCardView(title: "气体的制备", subject: "生物", chapter: 1, image: "化学实验图例", column: "", numbersOfProblems: 1, numbersOfCorrectAnswers: 8, score: 79, showBottom: true, liked: false, showArrow: true)
                            ExperimentCardView(title: "气体的制备", subject: "生物", chapter: 1, image: "化学实验图例", column: "", numbersOfProblems: 1, numbersOfCorrectAnswers: 8, score: 79, showBottom: true, liked: false, showArrow: true)
                            
                            Spacer()
                        }
                        
                    }.padding(.horizontal, 44).padding(.bottom,70)
                
            }
        
    }
}

struct MainHomepageContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainHomepageContentView()
    }
}


