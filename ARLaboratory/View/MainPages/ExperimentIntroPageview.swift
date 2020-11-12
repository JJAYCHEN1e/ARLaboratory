//
//  ExperimentIntroPageview.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/11/7.
//

import SwiftUI
import NavigationStack
struct ExperimentIntroPageview: View {
    @EnvironmentObject private var navigationStack: NavigationStack
    @State var bottomBarOffset: CGFloat = 100
    @State private var showSheet : Bool =  false
    @State var liked: Bool
    var title: String
    var subject: String
    var body: some View {
        ZStack {
            ZStack {
                
                
                VStack {
                    
                    Image(decodeBackground(subject: subject))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(1.01)
                    Spacer()
                }.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 10) {
                            Spacer()
                            Text(title).font(Font.system(size: 27).weight(.semibold)).foregroundColor(.white)
                            Text(decodeSubject(subject: subject)).font(Font.system(size: 17).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.8352941176, green: 0.831372549, blue: 1, alpha: 1)))
                        }
                        Spacer()
                        VStack {
                            Spacer()
                            HStack(spacing: 20) {
                                Button(action:{
                                                                    self.navigationStack.push(ConvexLabViewControllerContainer(leftAction: {
                                                                        self.navigationStack.pop()
                                                                    }))
                                }){
                                    RoundedRectangle(cornerRadius: 31).frame(width: 150, height: 40).foregroundColor(.white).overlay(
                                        Text("开始学习").font(Font.system(size: 18).weight(.semibold)).kerning(4).foregroundColor(Color(#colorLiteral(red: 0.5647058824, green: 0.3960784314, blue: 0.8666666667, alpha: 1)))
                                    )
                                }.buttonStyle(ResponsiveButtonStyle())
                                Button(action:{
                                    withAnimation(.linear, { liked.toggle()})
                                    clickLike(liked: liked, title: title)
                                }){
                                    Circle().foregroundColor(.white).frame(width: 40,height: 40)
                                        .overlay(
                                            
                                            ZStack {
                                                Circle().frame(width: 12,height: 12)
                                                    .foregroundColor(liked ? Color(#colorLiteral(red: 0.9921568627, green: 0.9490196078, blue: 0.7725490196, alpha: 1)) : Color(#colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)))
                                                
                                                Circle().frame(width: 40,height: 40)
                                                    .foregroundColor(liked ? Color(#colorLiteral(red: 0.9411764706, green: 0.5647058824, blue: 0.3647058824, alpha: 1)) : Color(#colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6274509804, alpha: 1)))
                                                    .mask(Image("star").resizable().frame(width: 23, height: 22))
                                            })
                                    
                                }.buttonStyle(ResponsiveButtonStyle())
                            }
                            
                            
                        }
                    }.padding(.vertical, 17).padding(.leading,80).frame(height: 168).padding(.trailing, 30)
                    TopRoundedRectangleView()
                        .overlay(
                            VStack(spacing: 30){
                                VStack(spacing: 20){
                                    SubtitleComponent(str: "实验目标",fontSize: 22)
                                    Group {
                                        Text("\t物理学中许多守恒的知识点，其中有个较为基础的是动量守恒，其描述为：在一个系统中，如果没有任何外力做功，那么该系统中各个物体的动量之和一定是守恒的。如果只有两个物体m1和m2，那么有一段时间前后")
                                        LatexTextView(text: "$m_1v_1+m_2v_2=m_1v\\prime_1m_2v\\prime_2$", fontSize: 20,fontColor: UIColor.init(fromHexString: "#848484"))
                                        Text("\t在实验具体操作中，我们使用两个小球的碰撞前后的系统动量和的变化情况，来验证动量守恒实验。")
                                    }.padding(.horizontal,25).font(Font.system(size: 17).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1))).lineSpacing(7)
                                }
                                VStack(spacing: 20){
                                    SubtitleComponent(str: "实验步骤",fontSize: 22)
                                    VStack(spacing: 15) {
                                        Text("\t在我们的应用中，我们已经消除了整个系统中的摩擦力，我们将预置的小球设置为刚性小球（即碰撞前后不发生能量损失")
                                        Text("1. 学生在应用寻找到平面后，在桌面上放置两个小球\n2. 点击小球即可设置小球初始的速度，同时也可以设置小球的质量，从而可以进行安排多组实验探究实验结果\n3. 点击开始按钮即可使得小球按照设置好的质量和初速度运动起来\n4. 应用会自动记录下两个小球碰撞前后的速度大小，并可以供学生随时查询\n5. 学生设计多组实验，归纳实验结果，得出结论").padding(.leading, 25)
                                        
                                    }.padding(.horizontal,25).font(Font.system(size: 17).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1))).lineSpacing(7)
                                }
                                Spacer()
                            }.padding(.top, 50).padding(.horizontal,73)
                        )
                }
                VStack {
                    HStack {
                        Image("back").resizable().frame(width: 48, height: 48)
                        Spacer()
                    }.padding(.horizontal,45).padding(.top,10).onTapGesture(perform: {
                        self.navigationStack.pop()
                    })
                    Spacer()
                }
            }.overlay(
                VStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color(#colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 0.95)))
                        .frame(width: 500, height: 70)
                        .overlay(
                            HStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(Color(#colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 1, alpha: 1)))
                                    .aspectRatio(1, contentMode: .fit)
                                    .overlay(Image("icon_challenge").resizable().aspectRatio(contentMode: .fit)
                                                .padding(.all, 5)
                                    )
                                VStack(alignment: .leading) {
                                    Text("答题挑战")
                                        .foregroundColor(.primaryColor)
                                        .font(.system(size: 18, weight: .bold))
                                    Text("接受挑战吧！")
                                        .foregroundColor(Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1)))
                                }
                                .padding(.horizontal, 5)
                                Spacer()
                                Text("挑战")
                                    .kerning(4)
                                    .foregroundColor(Color(#colorLiteral(red: 0.2862745098, green: 0.1137254902, blue: 0.5882352941, alpha: 1)))
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 20)
                                    .background(
                                        Capsule()
                                            .foregroundColor(Color(#colorLiteral(red: 0.8352941176, green: 0.831372549, blue: 1, alpha: 1)))
                                    )
                            }
                            .onTapGesture(perform: {
                                withAnimation(.easeInOut,{showSheet.toggle()})
                            })
                            
                            .padding(.horizontal, 24)
                            .padding(.vertical, 10)
                        )
                }
                .padding(.bottom, 24)
                .offset(x: 0, y: bottomBarOffset)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.spring()) {
                            bottomBarOffset = 0
                        }
                    }
                }
                , alignment: .bottom)
            .blur(radius: showSheet ? 5 : 0)
            CardViews( experimentName: title, showSheet: $showSheet)
                .offset(y : showSheet ? 0 : 2000)
        }
        
        
    }
    
}

struct ExperimentIntroPageview_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentIntroPageview(liked: false, title: "小球碰撞\n验证动量守恒定律实验", subject: "物理 - Physics")
    }
}

func decodeBackground(subject: String) -> String {
    switch subject {
    case "物理":
        return "backgroundForPhysics"
    case "化学":
        return "backgroundForChemistry"
    case "生物":
        return "backgroundForBiology"
    default:
        return "backgroundCandidate"
        
    }
}
