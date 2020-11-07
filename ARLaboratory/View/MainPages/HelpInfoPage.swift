//
//  HelpInfoPage.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/11/6.
//

import SwiftUI
import NavigationStack
struct HelpInfoPage: View {
    @EnvironmentObject private var navigationStack: NavigationStack

    var body: some View {
        ZStack{
            VStack {
                Image("backgroundCandidate")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(1.01)
                Spacer()
            }.ignoresSafeArea()
            VStack {
                ZStack{
                    HStack {
                        Image("back").resizable().frame(width: 48, height: 48).onTapGesture(perform: {
                            self.navigationStack.pop()
                        })
                        Spacer()
                    }.padding(.horizontal,45)
                    Text("帮助中心").font(Font.system(size: 27).weight(.semibold)).foregroundColor(.white).kerning(1).shadow(color: Color(#colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 0.32)), radius: 4, x: 0, y: 2)
                }.padding(.bottom,10).frame(height: 101)
                TopRoundedRectangleView().overlay(
                    VStack(spacing: 40){
                        VStack(spacing: 15){
                            HStack{
                                Image("bubbleQuestion").resizable().frame(width: 25, height: 25)
                                Text("什么是“ARLAB“?").font(Font.system(size: 20).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.2039215686, green: 0.262745098, blue: 0.337254902, alpha: 1)))
                                Spacer()
                            }
                            Text("“ARLAB”是一款基于Apple ARKit开发环境，致力于帮助6-18岁儿童关注物理，化学，生物等实验类学科的虚拟实验室，他不同于3D实验室或者是VR实验室，是一款轻松易懂的学习类软件，激发孩子的学习热情，探索感兴趣的学科，提供了不同于现实实验室的一种新的解决方案。").padding(.horizontal,33).font(Font.system(size: 17).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1))).lineSpacing(7)
                        }
                        
                        VStack(spacing: 15){
                            HStack{
                                Image("bubbleQuestion").resizable().frame(width: 25, height: 25)
                                Text("什么是“ARLAB“?").font(Font.system(size: 20).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.2039215686, green: 0.262745098, blue: 0.337254902, alpha: 1)))
                                Spacer()
                            }
                            Text("登陆后可以保存浏览记录以及收藏的实验，包括答题挑战等数据，下次再次打开的时候就能全部记住，哪怕是有其他人用了同一个软件，只要登陆后，所有关于你的记录都能被保存哦～").padding(.horizontal,33).font(Font.system(size: 17).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1))).lineSpacing(7)
                        }
                        
                        VStack(spacing: 15){
                            HStack{
                                Image("bubbleQuestion").resizable().frame(width: 25, height: 25)
                                Text("什么是“ARLAB“?").font(Font.system(size: 20).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.2039215686, green: 0.262745098, blue: 0.337254902, alpha: 1)))
                                Spacer()
                            }
                            Text("可以，前提是需要和小伙伴在同一局域网下，并且同时都开启着这款软件，如果无法进行实验的话，可以尝试检查：\n\t1.是否在同一局域网下 \n\t2.是否同时开启了软件 \n\t3.重启一下试试 \n\t4. 再打不开就是程序员的锅，你没错。").padding(.horizontal,33).font(Font.system(size: 17).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1))).lineSpacing(7)
                        }
                        Text("/ *  暂时没有更多  * /").font(Font.system(size: 14).weight(.bold)).foregroundColor(Color(#colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.6823529412, alpha: 1))).kerning(2).padding(.top, 40)
                        Spacer()
                    }.padding(.horizontal,63).padding(.vertical,71)
                )
            }
            
        }
    }
}

struct HelpInfoPage_Previews: PreviewProvider {
    static var previews: some View {
        HelpInfoPage()
    }
}
