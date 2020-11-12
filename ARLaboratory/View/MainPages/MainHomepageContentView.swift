//
//  MainHomepageContentView.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/11/3.
//

import SwiftUI
import NavigationStack
struct MainHomepageContentView: View {
    @EnvironmentObject private var navigationStack: NavigationStack
    @ObservedObject private var globalExperiments = GlobalExperiments()
    

    var body: some View {
        
        let count = globalExperiments.experiments.count
        let list1 = self.globalExperiments.experiments.subArray(fromIndex: 0, endIndex: count/3-1)
        let list2 = self.globalExperiments.experiments.subArray(fromIndex: count/3, endIndex: 2*count/3-1)
        let list3 = self.globalExperiments.experiments.subArray(fromIndex: 2*count/3, endIndex: count-1)
            VStack(spacing: 0) {
                VStack {
                    SubtitleComponent(str: "常用功能").padding(.bottom,10)
                    HStack {
                        
                        Button(action: {
                            self.navigationStack.push(ScorePageView())
                        }) {
                            Image("history").resizable().aspectRatio(contentMode: .fit)
                                .frame(width: 225, height: 95)
                                .shadow(color: Color(#colorLiteral(red: 0.8352941176, green: 0.831372549, blue: 1, alpha: 1)), radius: 15, x: 2, y: 2).overlay(
                                    HStack {
                                        HStack {
                                        Spacer()
                                        VStack(alignment: .trailing){
                                            Spacer()
                                            Text("排行榜").font(Font.system(size: 15).weight(.bold)).foregroundColor(Color(#colorLiteral(red: 0.9607843137, green: 0.9529411765, blue: 0.9529411765, alpha: 1))).kerning(1)
                                            Text("实验得分").font(Font.system(size: 12).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.8862745098, green: 0.8862745098, blue: 0.8862745098, alpha: 1))).kerning(0)
                                        }
                                        }.padding(.trailing,15).padding(.bottom,14)
                                    }
                            )
                        }.buttonStyle(ResponsiveButtonStyle())
                        Spacer()
                        
                        Button(action:{
                            self.navigationStack.push(LikedPageView())
                        }) {
                            Image("collection").resizable().aspectRatio(contentMode: .fit)
                                .frame(width: 225, height: 95)
                                .shadow(color: Color(#colorLiteral(red: 0.8274509804, green: 0.8862745098, blue: 0.9333333333, alpha: 1)), radius: 15, x: 2, y: 2)
                                .overlay(
                                HStack {
                                    Spacer()
                                    VStack(alignment: .trailing){
                                        Spacer()
                                        Text("收藏夹").font(Font.system(size: 15).weight(.bold)).foregroundColor(Color(#colorLiteral(red: 0.9607843137, green: 0.9529411765, blue: 0.9529411765, alpha: 1))).kerning(1)
                                        Text("最爱实验").font(Font.system(size: 12).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.8862745098, green: 0.8862745098, blue: 0.8862745098, alpha: 1))).kerning(0)
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
                                        Text("快来参加叭").font(Font.system(size: 12).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.8862745098, green: 0.8862745098, blue: 0.8862745098, alpha: 1))).kerning(0)
                                    }
                                }.padding(.trailing,15).padding(.bottom,14)
                            )
                        }.buttonStyle(ResponsiveButtonStyle())
                    }
                }.padding(.horizontal,53).padding(.bottom,10)
                
                
                SubtitleComponent(str: "推荐实验").padding(.horizontal,53).padding(.vertical,10).padding(.top,10)
                ScrollView {
                    HStack(alignment: .top,spacing: 0){
                            
                            LazyVStack{
                                ForEach(0..<list1.count, id: \.self){ index in
                                    let experiment = list1[index]
                                    if index == 0 {
                                        ExperimentCardView(title: "5大实验揭秘“力”", subject: "", chapter: -1, image: "5大实验揭秘“力”", column: "物理", numbersOfProblems: -1, numbersOfCorrectAnswers: -1, score: -1, showBottom: true, liked: false,  showArrow: false)
                                        
                                    }
                                    
                                    ExperimentCardView(title: experiment.title, subject: experiment.subject, chapter: experiment.chapter, image: experiment.image, column: "", numbersOfProblems: experiment.numbersOfProblems, numbersOfCorrectAnswers: experiment.numbersOfCorectAnswer, score: experiment.score, showBottom: false, liked: experiment.liked,  showArrow: true)
                                }
                                
                            
                                Spacer()
                            }
                            Spacer()
                            LazyVStack{
                                ForEach(0..<list2.count, id: \.self){ index in
                                    let experiment = list2[index]
                                    if index == 2 {
                                        ExperimentCardView(title: "生物实验大全", subject: "", chapter: -1, image: "生物实验大全", column: "生物", numbersOfProblems: -1, numbersOfCorrectAnswers: -1, score: -1, showBottom: true, liked: false,  showArrow: false)
                                        
                                    }
                                    ExperimentCardView(title: experiment.title, subject: experiment.subject, chapter: experiment.chapter, image: experiment.image, column: "", numbersOfProblems: experiment.numbersOfProblems, numbersOfCorrectAnswers: experiment.numbersOfCorectAnswer, score: experiment.score, showBottom: false, liked: experiment.liked,  showArrow: true)
                                }
                                
                                Spacer()
                            }
                            Spacer()
                            LazyVStack{
                                ForEach(0..<list3.count, id: \.self){ index in
                                    let experiment = list3[index]
                                    if index == 1 {
                                        ExperimentCardView(title: "经典化学实验", subject: "", chapter: -1, image: "经典化学实验", column: "化学", numbersOfProblems: -1, numbersOfCorrectAnswers: -1, score: -1, showBottom: true, liked: false,  showArrow: false)
                                        
                                    }
                                    ExperimentCardView(title: experiment.title, subject: experiment.subject, chapter: experiment.chapter, image: experiment.image, column: "", numbersOfProblems: experiment.numbersOfProblems, numbersOfCorrectAnswers: experiment.numbersOfCorectAnswer, score: experiment.score, showBottom: false, liked: experiment.liked,  showArrow: true)
                                }
                                
                                Spacer()
                            }
                            
                    }.padding(.horizontal, 44).padding(.bottom,70)
                }
                
            }
        
    }
}

struct MainHomepageContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainHomepageContentView()
    }
}

extension Array{
    func subArray(fromIndex: Int, endIndex: Int) -> Array {
        var tmp : Array = []
        if endIndex < fromIndex {
            return tmp
            
        }
        for i in fromIndex...endIndex{
            tmp.append(self[i])
        }
        return tmp
    }
}
