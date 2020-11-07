//
//  ScoreCircleView.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/11/7.
//

import SwiftUI

struct ScoreCircleView: View {
    var percentage: CGFloat
    var width : CGFloat
    var score: Int
    var innerLineWidth: CGFloat = 2
    var outerLineWidth: CGFloat = 5
    var fontSize:  CGFloat = 14
    var shadowOffsetX: CGFloat = -2
    var shadowOffsetY: CGFloat = -4
    var shadowRadius: CGFloat = 4
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: innerLineWidth))
                .frame(width: width, height: width)
            
            Circle()
                .trim(from: 0.0, to: percentage)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5450980392, green: 0.3960784314, blue: 0.9490196078, alpha: 0.66)), Color(#colorLiteral(red: 0.5450980392, green: 0.3960784314, blue: 0.9490196078, alpha: 0.66))]), startPoint: .bottomTrailing, endPoint: .topLeading),
                    style: StrokeStyle(lineWidth: outerLineWidth, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0)
                )
                .rotationEffect(Angle(degrees: -90))
                .frame(width: width, height: width)
                .shadow(color: Color(#colorLiteral(red: 0.462745098, green: 0.5294117647, blue: 0.8941176471, alpha: 0.5)), radius: shadowRadius, x: -2, y: 4)
            (score < 0 ? Text("Go") : Text("\(score)"))
                .foregroundColor(Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1)))
                .font(Font.system(size: fontSize).weight(.semibold))
                .fontWeight(.bold)
        }
    }
}

struct ScoreCircleView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreCircleView(percentage: 0.7, width: 44, score: 100,fontSize: 14)
    }
}
