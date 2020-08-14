//
//  LabIntroView.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/12.
//

import SwiftUI

struct LabIntroView: View {
    @State private var bottomBarOffset: CGFloat = 100.0
    
    var lab: Lab
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                LabIntroHeadView(lab: lab)
                
                HStack {
                    VStack {
                        LabTarget()
                            .padding(.top)
                        
                        LabStep()
                            .padding(.top)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 40)
                .padding(.vertical)
                
                Spacer()
            }
        }
        .overlay(
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color(#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 0.95)))
                    .frame(width: 500, height: 70)
                    .shadow(color: Color.black
                                .opacity(0.05), radius: 1, x: 0, y: 1)
                    .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 0.0, y: 10)
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
                                .foregroundColor(.primaryColor)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 20)
                                .background(
                                    Capsule()
                                        .foregroundColor(Color(#colorLiteral(red: 0.8862745098, green: 0.8862745098, blue: 0.8862745098, alpha: 1)))
                                )
                        }
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
        .background(Color(#colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9607843137, alpha: 0.5)))
        .navigationTitle(lab.rawTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LabIntroView_Previews: PreviewProvider {
    static var previews: some View {
        LabIntroView(lab: labs.first!)
    }
}

struct LabIntroHeadView: View {
    var lab: Lab
    
    var body: some View {
        Rectangle()
            .fill(LinearGradient(gradient:
                                    Gradient(
                                        colors: [Color(#colorLiteral(red: 0.8, green: 0.6823529412, blue: 0.9647058824, alpha: 1)), Color(#colorLiteral(red: 0.4156862745, green: 0.368627451, blue: 0.9568627451, alpha: 1))]),
                                 startPoint: UnitPoint(x: 0.5, y: -0.5),
                                 endPoint: .bottom)
            )
            .frame(height: screenHeight / 3)
            .foregroundColor(.blue)
            .overlay(
                ZStack {
                    Image(lab.illustrationImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.all, 20)
                    ZStack(alignment: .bottomLeading) {
                        ZStack(alignment: .topTrailing) {
                            VStack {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(lab.subtitle)
                                            .font(Font.system(size: 18).weight(.medium))
                                            .foregroundColor(Color.white.opacity(0.8))
                                        Text(lab.title)
                                            .font(Font.system(size: 28).weight(.medium))
                                            .foregroundColor(.white)
                                    }
                                    Spacer()
                                }
                                Spacer()
                            }
                            
                            Button(action: {}, label: {
                                Circle()
                                    .foregroundColor(Color(#colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.4156862745, alpha: 0.68)))
                                    .shadow(color: Color.black.opacity(0.05), radius: 1, x: 0, y: 1)
                                    .shadow(color: Color(#colorLiteral(red: 0.5215686275, green: 0.4705882353, blue: 1, alpha: 1)), radius: 5, x: 0, y: 10)
                                    .overlay(
                                        Image(systemName: "star")
                                            .foregroundColor(Color.white.opacity(1))
                                            .padding()
                                            .font(.title2)
                                    )
                                    .frame(width: 44, height: 44)
                                
                            })
                        }
                        
                        Text("进入 AR 实验")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primaryColor)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 24)
                            .background(
                                Capsule()
                                    .foregroundColor(.white)
                            )
                    }
                    .padding(.horizontal, 40)
                    .padding(.vertical, 40)
                }
            )
    }
}

struct LabTarget: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("实验目标")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primaryColor)
                .padding(.vertical, 10)
                .padding(.leading, 50)
                .padding(.trailing, 24)
                .background(
                    Capsule()
                        .foregroundColor(Color(#colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 1, alpha: 1)))
                    
                    
                )
                .overlay(
                    HStack {
                        Circle()
                            .frame(width: 36)
                            .foregroundColor(Color(#colorLiteral(red: 0.2745098039, green: 0.2745098039, blue: 0.8549019608, alpha: 1)))
                            .overlay(
                                Text("1")
                                    .font(.title3)
                                    .foregroundColor(.white)
                            )
                        Spacer()
                    }
                )
            
            Group {
                Text( "自然界中存在着三大守恒定律，它们分别是动量守恒定律，能量守恒定律以及角动量守恒定律。它们一起成为现代物理学中的三大基本守恒定律。")
                    .padding(.top, 5)
                Text("其中，动量守恒定律描述为：在一个系统中，如果没有任何外力做功，那么该系统中各个物体的动量之和一定是守恒的。如果只有两个物体，那么在一段时间前后满足：")
                    .padding(.top, 5)
                
                HStack {
                    Spacer()
                    LatexTextView(text: "$m_1v_1+m_2v_2=m_1v\\prime_1m_2v\\prime_2$", fontSize: 20)
                    Spacer()
                }
                
                Text("在本次实验中，我们将使用两个小球进行对心碰撞，不断记录、观察碰撞前后系统动量和的变化情况，来验证动量守恒定律。")
                    .padding(.top, 5)
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal)
            .font(.system(size: 17))
            .foregroundColor(Color(#colorLiteral(red: 0.2470588235, green: 0.2470588235, blue: 0.2470588235, alpha: 1)))
        }
    }
}

struct LabStep: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("实验步骤")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primaryColor)
                .padding(.vertical, 10)
                .padding(.leading, 50)
                .padding(.trailing, 24)
                .background(
                    Capsule()
                        .foregroundColor(Color(#colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 1, alpha: 1)))
                    
                    
                )
                .overlay(
                    HStack {
                        Circle()
                            .frame(width: 36)
                            .foregroundColor(Color(#colorLiteral(red: 0.2745098039, green: 0.2745098039, blue: 0.8549019608, alpha: 1)))
                            .overlay(
                                Text("2")
                                    .font(.title3)
                                    .foregroundColor(.white)
                            )
                        Spacer()
                    }
                )
            
            Group {
                Text("在我们的应用中，我们模拟了真实世界中的摩擦力与弹性碰撞系数，使得实验数据具有一定的波动性，同时具有真实性。")
                    .padding(.top, 5)
                Text("·根据提示完成平面检测")
                    .padding(.top, 5)
                Text("·完成平面检测后，根据提示在桌面上放置两个小球")
                    .padding(.top, 5)
                Text("·点击小球即可设置小球的初速度与质量")
                    .padding(.top, 5)
                Text("·设置完成小球的属性后，可以选择让小球开始对心碰撞")
                    .padding(.top, 5)
                Text("·应用会自动记录下两个小球碰撞前后的速度大小")
                    .padding(.top, 5)
                Text("·进行多组实验，根据实验数据归纳实验结果，验证动量守恒定律")
                    .padding(.top, 5)
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal)
            .font(.system(size: 17))
            .foregroundColor(Color(#colorLiteral(red: 0.2470588235, green: 0.2470588235, blue: 0.2470588235, alpha: 1)))
        }
    }
}
