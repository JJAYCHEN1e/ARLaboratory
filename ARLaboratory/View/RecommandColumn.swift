//
//  RecommandColumn.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/8.
//

import SwiftUI

struct RecommandColumn: View {
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(labs, id: \.title) {
                    lab in
                    RecommandCard(title: lab.title, subtitle: lab.subtitle, illustrationImage: lab.illustrationImage, linearGradient: lab.gradient, performance: lab.performance ?? 0.0)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 24)
        }
    }
}

struct RecommandCard: View {
    var title: String
    var subtitle: String
    var illustrationImage: String
    var linearGradient: LinearGradient
    var performance: CGFloat?
    var startColor: Color?
    var endColor: Color?
    
    let cardWidth: CGFloat = 295
    let cardHeight: CGFloat = 339
    let illustrationHeight: CGFloat = 150
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(linearGradient)
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
                    .minimumScaleFactor(0.5)
                
                Spacer()
                
                Image("\(illustrationImage)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.blue)
                    .frame(height: illustrationHeight)
                
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
                                Spacer()
                                Text(performance != nil ? "2020-08-03 14:00" : "暂无")
                                    .font(Font.caption.weight(.semibold))
                                    .foregroundColor(Color.white.opacity(0.6))
                            }
                            
                            Spacer()
                            
                            RingView(percentage: (performance ?? 0) / 100)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    )
            }
            .padding()
        }
        .frame(width: cardWidth, height: cardHeight)
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

struct RecommandColumn_Previews: PreviewProvider {
    static var previews: some View {
        RecommandColumn()
    }
}
