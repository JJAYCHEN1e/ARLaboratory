//
//  RecommandColumn.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/8.
//

import SwiftUI

struct RecommandColumn: View {
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 15)
                    .fill(LinearGradient(
                            gradient: Gradient(stops: [
                                                .init(color: Color.from(hexString: "#CCAEF6"), location: 0),
                                                .init(color: Color.from(hexString: "#6A5EF4"), location: 1)]),
                            startPoint: UnitPoint(x: 0.3, y: -0.1),
                            endPoint: UnitPoint(x: 0.8, y: 1.1)))
                    .frame(width: 295, height: 339)
                    .shadow(color: Color.white.opacity(0.05), radius:3, x:0, y:1)
                    .shadow(color: Color.from(hexString: "#9D9DE1").opacity(0.4), radius: 10, x: 0, y: 10)
                
                VStack(alignment: .leading) {
                    Text("初中物理")
                        .font(Font.system(size: 15).weight(.semibold))
                        .foregroundColor(Color.white.opacity(0.8))
                        .padding(.bottom, 0)
                    
                    Text("小球碰撞\n验证动量守恒定律")
                        .font(Font.system(size: 26).weight(.semibold))
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    Image("illustrations_momentum")
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
                                    Spacer()
                                    Text("2020-08-03 14:00")
                                        .font(Font.caption.weight(.semibold))
                                        .foregroundColor(Color.white.opacity(0.6))
                                }
                                
                                Spacer()
                            }
                            .padding()
                        )
                }
                .padding(.horizontal, 20)
                .padding(.vertical)
            }
            .frame(width: 295, height: 339)
        }
        .padding(.horizontal)
    }
}
