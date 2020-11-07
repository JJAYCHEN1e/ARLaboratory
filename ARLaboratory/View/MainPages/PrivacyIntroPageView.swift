//
//  PrivacyIntroPageView.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/11/6.
//

import SwiftUI
import NavigationStack
struct PrivacyIntroPageView: View {
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
                    Text("隐私和政策").font(Font.system(size: 27).weight(.semibold)).foregroundColor(.white).kerning(1).shadow(color: Color(#colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 0.32)), radius: 4, x: 0, y: 2)
                }.padding(.bottom,10).frame(height: 101)
                TopRoundedRectangleView().overlay(
                    VStack(spacing: 40){
                        VStack(spacing: 15){
                            HStack{
                                Image("bubbleQuestion").resizable().frame(width: 25, height: 25)
                                Text("我们的隐私政策").font(Font.system(size: 20).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.2039215686, green: 0.262745098, blue: 0.337254902, alpha: 1)))
                                Spacer()
                            }
                            Text("我们深知个人信息对您的重要性，您的信任对我们非常重要，我们将按法律法规要求采取相应安全保护措施，致力于保护您的个人信息安全可控。我们向您做出如下承诺：\n\t1. 我们承诺不将您的账号信息向外界泄露\n\t2. 我们承诺不将您的实验喜好、收藏信息等用作商业用途\n\t3. 所有推荐过程将在您的 iPad/iPhone 上进行，不会保存您的推荐结果\n\t4. 不向您申请位置信息等无关个人信息 ").padding(.horizontal,33).font(Font.system(size: 17).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1))).lineSpacing(7)
                        }
                        
                        
                        Text("/ *  暂时没有更多  * /").font(Font.system(size: 14).weight(.bold)).foregroundColor(Color(#colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.6823529412, alpha: 1))).kerning(2).padding(.top, 40)
                        Spacer()
                    }.padding(.horizontal,63).padding(.vertical,71)
                )
            }
            
        }
    }
}

struct PrivacyIntroPageView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyIntroPageView()
    }
}
