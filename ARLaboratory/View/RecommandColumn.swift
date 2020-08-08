//
//  RecommandColumn.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/8.
//

import SwiftUI

let linearGradients = [
    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8, green: 0.6823529412, blue: 0.9647058824, alpha: 1)), Color(#colorLiteral(red: 0.4156862745, green: 0.368627451, blue: 0.9568627451, alpha: 1))]),
                   startPoint: UnitPoint(x: 0.3, y: -0.1),
                   endPoint: UnitPoint(x: 0.8, y: 1.1)),
    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.7443302274, blue: 0.4703813195, alpha: 1)), Color(#colorLiteral(red: 0.9647058824, green: 0.5019607843, blue: 0.5019607843, alpha: 1))]),
                   startPoint: UnitPoint(x: 0, y: 0),
                   endPoint: UnitPoint(x: 1, y: 1)),
    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9568627451, green: 0.9176470588, blue: 0.8862745098, alpha: 1)), Color(#colorLiteral(red: 0.4274509804, green: 0.6117647059, blue: 0.7529411765, alpha: 1))]),
                   startPoint: UnitPoint(x: 0, y: -0.5),
                   endPoint: UnitPoint(x: 1, y: 1)),
]

struct RecommandColumn: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                RecommandCard(title: "小球碰撞\n验证动量守恒定律", subtitle: "初中物理", illustrationImage: "illustrations_momentum", linearGradient: linearGradients[0], grade: 82)
                RecommandCard(title: "探究凸透镜\n成像规律", subtitle: "初中物理", illustrationImage: "illustrations_convex", linearGradient: linearGradients[1])
                RecommandCard(title: "化学分子\n晶体模型展示", subtitle: "初中化学", illustrationImage: "illustrations_cell", linearGradient: linearGradients[2])
                RecommandCard(title: "小球碰撞\n验证动量守恒定律", subtitle: "初中物理", illustrationImage: "illustrations_momentum", linearGradient: linearGradients[0], grade: 82)
                RecommandCard(title: "探究凸透镜\n成像规律", subtitle: "初中物理", illustrationImage: "illustrations_convex", linearGradient: linearGradients[1])
                RecommandCard(title: "化学分子\n晶体模型展示", subtitle: "初中化学", illustrationImage: "illustrations_cell", linearGradient: linearGradients[2])
            }
            .padding(.horizontal)
            .padding(.bottom, 28)
        }
    }
}

struct RecommandCard: View {
    var title: String
    var subtitle: String
    var illustrationImage: String
    var linearGradient: LinearGradient
    var grade: CGFloat?
    var startColor: Color?
    var endColor: Color?
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(linearGradient)
                .frame(width: 295, height: 339)
                .shadow(color: Color.white.opacity(0.05), radius:3, x:0, y:1)
                .shadow(color: Color(#colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.8823529412, alpha: 1)).opacity(0.4), radius: 10, x: 0, y: 10)
            
            VStack(alignment: .leading) {
                Text("\(subtitle)")
                    .font(Font.system(size: 15).weight(.semibold))
                    .foregroundColor(Color.white.opacity(0.8))
                    .padding(.bottom, 0)
                
                Text("\(title)")
                    .font(Font.system(size: 26).weight(.semibold))
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Image("\(illustrationImage)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.blue)
                    .frame(height: 150)
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.white.opacity(0.4))
                    .frame(height: 60)
                    .overlay(
                        HStack {
                            VStack(alignment: .leading) {
                                Text("自我测验成绩")
                                    .font(Font.subheadline.weight(.semibold))
                                    .foregroundColor(.white)
                                    .padding(.top, 12)
                                Spacer()
                                Text(grade != nil ? "2020-08-03 14:00" : "暂无")
                                    .font(Font.caption.weight(.semibold))
                                    .foregroundColor(Color.white.opacity(0.6))
                                    .padding(.bottom, 12)
                            }
                            
                            Spacer()
                            
                            RingView(percentage: (grade ?? 0) / 100)
                        }
                        .padding(.horizontal)
                    )
            }
            .padding(.horizontal, 20)
            .padding(.vertical)
        }
        .frame(width: 295, height: 339)
    }
}

fileprivate struct RingView: View {
    var percentage: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5))
                .frame(width: 44, height: 44)
            
            Circle()
                .trim(from: 0.0, to: percentage)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7730026841, green: 1, blue: 0.9720677733, alpha: 1)), Color(#colorLiteral(red: 0.4782336354, green: 0.7739011645, blue: 0.7504651546, alpha: 1))]), startPoint: .bottomTrailing, endPoint: .topLeading),
                    style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0)
                )
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 44, height: 44)
                .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.1), radius: 3, x: 0, y: 3)
            Text("\(Int(percentage * 100))")
                .foregroundColor(.white)
                .font(.subheadline)
                .fontWeight(.bold)
        }
    }
}

