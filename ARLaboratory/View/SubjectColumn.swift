//
//  SubjectColumn.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/8.
//

import SwiftUI

struct SubjectColumn: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                SubjectCard(title: "物理", subtitle: "Physics", description: "包含初高中物理学科中的力学、光学、电磁学等各方向的实验。", numberOfLabs: 5, illustrationImage: "subject_physics_illustration")
                SubjectCard(title: "化学", subtitle: "Chemistry", description: "包含初高中化学学科中微观、宏观，有机、无机等各方向的实验。", numberOfLabs: 2, illustrationImage: "subject_chemistry_illustration")
                SubjectCard(title: "生物", subtitle: "Biology", description: "包含初高中生物学科的分子与细胞、遗传与进化、稳态与环境等方向的实验。", numberOfLabs: 5, illustrationImage: "subject_biology_illustration")
            }
            .padding(.horizontal)
            .padding(.bottom, 28)
        }
    }
}

struct SubjectCard: View {
    var title: String
    var subtitle: String
    var description: String
    var numberOfLabs: Int
    var illustrationImage: String
    
    let cardWidth: CGFloat = 300
    let cardHeight: CGFloat  = 180
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .overlay(Image("subject_background").resizable())
                .cornerRadius(25)
                .shadow(color: Color.white.opacity(0.05), radius:3, x:0, y:1)
                .shadow(color: Color(#colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 1)).opacity(0.4), radius: 15, x: 0, y: 5)
            
            GeometryReader { proxy in
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(subtitle)")
                            .font(Font.subheadline.weight(.semibold))
                        Text("\(title)")
                            .font(Font.title.bold())
                        
                        Spacer()
                        Text("\(description)")
                            .font(Font.caption2)
                            .foregroundColor(Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1)))
                        Spacer()
                        Text("共 \(numberOfLabs) 个实验")
                            .font(.caption2)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(
                                Capsule()
                                    .stroke()
                            )
                            .foregroundColor(Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1)))
                    }
                    .foregroundColor(.primaryColor)
                    .frame(idealWidth: proxy.size.width / 2, maxWidth: proxy.size.width / 2)
                    .padding()
                    
                    VStack {
                        Image(illustrationImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.trailing, 5)
                    }
                    .frame(idealWidth: proxy.size.width / 2, maxWidth: proxy.size.width / 2)
                }
            }
            
        }
        .frame(width: cardWidth, height: cardHeight)
        .foregroundColor(.white)
    }
}

struct SubjectColumn_Previews: PreviewProvider {
    static var previews: some View {
        SubjectColumn()
    }
}
