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
                                Button(action: 
                                {
                                    self.navigationStack.push(ConvexLabViewControllerContainer(leftAction: {
                                        self.navigationStack.pop()
                                    }))
                                }
                                ){
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
                    }.ignoresSafeArea()
                    .padding(.vertical, 17).padding(.leading,80).frame(height: 168).padding(.trailing, 30).padding(.top, 25)
                    TopRoundedRectangleView()
                        .overlay(
                            ScrollView {
                                LazyVStack(spacing: 30){
                                    VStack(spacing: 20){
                                        VStack(spacing: 10){
                                            SubtitleComponent(str: "实验目标",fontSize: 22)
                                            
                                            Text("\t探究凸透镜成像规律是初中光学部分的重中之重，呈现规律较多，变化相对复杂。从能力要求来看，对学生的抽象思维能力、探究实验设计能力、动手能力以及测量能力、分析和归纳能力都是一个考验，是一个完整的探究题目。我们需要通过这项实验完成以下两个目标：")
                                            
                                            Text("\t1.  通过观察和实验，加深对实验和虚像的认识，收集有关凸透镜成像规律的数据和资料。\n\t2.  观察凸透镜成像的有关现象和收集实验数据，并从中归纳出凸透镜成像的规律。")
                                        }.font(Font.system(size: 17).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1))).lineSpacing(7)
                                    }
                                    VStack(spacing: 10) {
                                        SubtitleComponent(str: "实验表格",fontSize: 22)
                                        Image("convex_lab_table").resizable().frame(width: 500,height: 170).padding()
                                        
                                    }
                                    
                                    
                                    
                                    VStack(spacing: 20){
                                        SubtitleComponent(str: "实验步骤",fontSize: 22)
                                        VStack(alignment: .leading, spacing: 15) {
                                            Text("\t在我们的应用中，我们已经消除了整个系统中的摩擦力，我们将预置的小球设置为刚性小球（即碰撞前后不发生能量损失")
                                            Group{
                                                Text("1.  把透镜放在光具座标尺中回央答,从透镜的位置开始在左右两边的标尺上用粉笔标出等于焦距和2倍焦距的位置.")
                                                Text("2.  点燃蜡烛,调整它们的高度,使烛焰、凸透镜、光屏的中心大致在同一高度.")
                                                
                                                Text("3.  把蜡烛放在离凸透镜尽量远的位置上,调整光屏到透镜的距离,使烛焰在屏上成一个清晰的像,观察像的大小、正倒,测出蜡烛与凸透镜、凸透镜与光屏间的距离.把数据记录在表格中.")
                                                Text("4.  继续把蜡烛向凸透镜靠近,观察像的变化是放大还是缩小,是正立还是倒立,蜡烛与凸透镜、凸透镜与光屏的距离测出,将数据记录在表格中.")
                                                Text("5.  当蜡烛到一定位置上时,光屏没有像,用眼睛直接对着凸透镜观察蜡烛的像,把蜡烛与凸透镜、像与凸透镜的距离,像是放大还是缩小的,像的正倒,填入表格中。")
                                                
                                            }.padding(.leading, 10)
                                            
                                        }.padding(.horizontal,25).font(Font.system(size: 17).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 1))).lineSpacing(7)
                                    }
                                    Spacer()
                                }.padding(.top, 50).padding(.horizontal,73)
                            }
                        )
                }
                VStack {
                    HStack {
                        Image("back").resizable().frame(width: 48, height: 48)
                        Spacer()
                    }.padding(.horizontal,45).padding(.top,35).onTapGesture(perform: {
                        self.navigationStack.pop()
                    })
                    Spacer()
                }
            }
            .overlay(
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
        ExperimentIntroPageview(liked: false, title: "小球碰撞\n验证动量守恒定律实验", subject: "物理")
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
