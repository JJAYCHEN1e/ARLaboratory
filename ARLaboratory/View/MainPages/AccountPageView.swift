//
//  AccountPageView.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/11/6.
//

import SwiftUI
import NavigationStack
struct AccountPageView: View {
    @EnvironmentObject private var navigationStack: NavigationStack

    var body: some View {
        VStack {
            HStack {
                Text("实验者").font(Font.system(size: 27).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1))).kerning(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                Image("logIn").resizable().frame(width: 24, height: 24)
            }.padding(.bottom, 3)
            
            Text("这是你来到ARLab的第一天~").font(Font.system(size: 17).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.6823529412, alpha: 1)))
                .padding(.bottom, 10)
            FunctionBarView().padding(.bottom, 30)
            SubtitleComponent(str: "设置和帮助").padding(.horizontal, 54).padding(.bottom,20)

            
            VStack (spacing: 23){
                RoundedRectangle(cornerRadius: 15).frame(height: 224).foregroundColor(.white).shadow(color: Color(#colorLiteral(red: 0.2352941176, green: 0.5019607843, blue: 0.8196078431, alpha: 0.12)), radius: 19, x: 0, y: 12).overlay(
                    VStack{
                        Spacer()
                        HStack{
                            Image("score").resizable().frame(width: 38, height: 38).padding(.trailing, 5)
                            Text("成绩隐藏").font(Font.system(size: 17).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.2039215686, green: 0.262745098, blue: 0.337254902, alpha: 1)))
                            Spacer()
                        }.padding(.horizontal,25)
                        Spacer()

                        HStack{
                            Image("new").resizable().frame(width: 38, height: 38).padding(.trailing, 5)
                            Text("课程更新").font(Font.system(size: 17).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.2039215686, green: 0.262745098, blue: 0.337254902, alpha: 1)))
                            Spacer()
                        }.padding(.horizontal,25)
                        Spacer()

                        HStack{
                            Image("study").resizable().frame(width: 38, height: 38).padding(.trailing, 5)
                            Text("学习提醒").font(Font.system(size: 17).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.2039215686, green: 0.262745098, blue: 0.337254902, alpha: 1)))
                            Spacer()
                        }.padding(.horizontal,25)
                        Spacer()

                    })
                
                RoundedRectangle(cornerRadius: 15).frame(height: 224).foregroundColor(.white).shadow(color: Color(#colorLiteral(red: 0.2352941176, green: 0.5019607843, blue: 0.8196078431, alpha: 0.12)), radius: 19, x: 0, y: 12).overlay(
                    VStack{
                        Spacer()
                        Button(action: {self.navigationStack.push(HelpInfoPage())}){
                        HStack{
                            Image("help").resizable().frame(width: 38, height: 38).padding(.trailing, 5)
                            Text("帮助中心").font(Font.system(size: 17).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.2039215686, green: 0.262745098, blue: 0.337254902, alpha: 1)))
                            Spacer()
                            Image("grayArrow").resizable().frame(width: 7, height: 11)
                        }.padding(.horizontal,25)
                        
                    }
                        Spacer()
                        Button(action: {self.navigationStack.push(PrivacyIntroPageView())}){
                        HStack{
                            Image("privacy").resizable().frame(width: 38, height: 38).padding(.trailing, 5)
                            Text("隐私和政策").font(Font.system(size: 17).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.2039215686, green: 0.262745098, blue: 0.337254902, alpha: 1)))
                            Spacer()
                            Image("grayArrow").resizable().frame(width: 7, height: 11)

                        }.padding(.horizontal,25)}
                        Spacer()

                        HStack{
                            Image("contact").resizable().frame(width: 38, height: 38).padding(.trailing, 5)
                            Text("联系我们").font(Font.system(size: 17).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.2039215686, green: 0.262745098, blue: 0.337254902, alpha: 1)))
                            Spacer()
                            Image("grayArrow").resizable().frame(width: 7, height: 11)

                        }.padding(.horizontal,25)
                        Spacer()

                    })
                Spacer()
            }.padding(.horizontal, 54)
        }
    }
}

struct AccountPageView_Previews: PreviewProvider {
    static var previews: some View {
        AccountPageView()
    }
}
