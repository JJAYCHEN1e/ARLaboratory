//
//  FunctionBarView.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/11/6.
//

import SwiftUI
import NavigationStack
struct FunctionBarView: View {
    @EnvironmentObject private var navigationStack: NavigationStack

    var body: some View {
        RoundedRectangle(cornerRadius: 16).frame(width: 774, height: 125).foregroundColor(.white).shadow(color: Color(#colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)), radius: 15, x: 0, y: 2).overlay(
            HStack(spacing: 0){
                    Button(action: {}) {
                        Spacer()
                        HStack{
                            Image("成绩").resizable().frame(width: 48, height: 48).padding(.horizontal, 4)
                            VStack(alignment: .leading){
                                Text("实验成绩").font(Font.system(size: 22).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1))).kerning(0.92)
                                Spacer()
                                Text("查看更多").font(Font.system(size: 17).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.6823529412, alpha: 1))).kerning(0.71)
                            }
                            Image("rightArrow").resizable().frame(width: 24, height: 24).padding(.horizontal, 4)
                        }.padding(.vertical, 35)
                        Spacer()
                    }
                    
                    RoundedRectangle(cornerRadius: 0.5).frame(width: 1).foregroundColor(Color(#colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1))).padding(.vertical, 25)
                    Button(action: {
                        self.navigationStack.push(LikedPageView())
                    }) {
                        Spacer()
                        HStack{
                            Spacer()
                            Image("收藏").resizable().frame(width: 48, height: 48).padding(.horizontal, 4)
                            VStack(alignment: .leading){
                                Text("收藏").font(Font.system(size: 22).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1))).kerning(0.92)
                                Spacer()
                                Text("查看收藏").font(Font.system(size: 17).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.6823529412, alpha: 1))).kerning(0.71)
                            }
                            Image("rightArrow").resizable().frame(width: 24, height: 24).padding(.horizontal, 4)
                            Spacer()
                        }.padding(.vertical, 35)
                    }
                    
                    RoundedRectangle(cornerRadius: 0.5).frame(width: 1).foregroundColor(Color(#colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1))).padding(.vertical, 25)

                    Button(action: {}) {
                        Spacer()
                        HStack{
                            Image("好友").resizable().frame(width: 48, height: 48).padding(.horizontal, 4)
                            VStack(alignment: .leading){
                                Text("好友").font(Font.system(size: 22).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1))).kerning(0.92)
                                Spacer()
                                Text("好友一起玩").font(Font.system(size: 17).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.6823529412, alpha: 1))).kerning(0.71)
                            }
                            Image("rightArrow").resizable().frame(width: 24, height: 24).padding(.horizontal, 4)

                        }.padding(.vertical, 35)
                        Spacer()
                    }
                
            })
    }
}

struct FunctionBarView_Previews: PreviewProvider {
    static var previews: some View {
        FunctionBarView()
    }
}

