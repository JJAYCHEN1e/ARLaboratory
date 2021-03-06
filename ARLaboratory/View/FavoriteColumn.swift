//
//  FavoriteColumn.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/9.
//

import SwiftUI

struct FavoriteColumn: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(labs, id: \.title) {
                    lab in
                    FavoriteCard(title: lab.title, subtitle: lab.subtitle, illustrationImage: lab.illustrationImage)
                        .navigationLinkWithResponsiveButtonStype(desination: LabIntroView(lab: lab))
                }
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 24)
        }
    }
}

struct FavoriteCard: View {
    var title: String
    var subtitle: String
    var illustrationImage: String
    
    let cardWidth: CGFloat = 300
    let cardHeight: CGFloat  = 250
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .cornerRadius(25)
                .foregroundColor(.white)
                .shadow(color: Color.white.opacity(0.05), radius:3, x:0, y:1)
                .shadow(color: Color(#colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 1)).opacity(0.4), radius: 15, x: 0, y: 5)
            
            GeometryReader { proxy in
                VStack {
                    Image(illustrationImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top)
                    
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading){
                            Text("\(subtitle)")
                                .font(Font.system(size: 14).bold())
                                .foregroundColor(.primaryColor)
                            Text("\(title)")
                                .font(Font.title3.weight(.medium))
                                .foregroundColor(Color(#colorLiteral(red: 0.2156862745, green: 0.2156862745, blue: 0.2156862745, alpha: 1)))
                            
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            
        }
        .frame(idealWidth: cardWidth, maxWidth: cardWidth, idealHeight: cardHeight, maxHeight: cardHeight)
        .buttonStyle(ResponsiveButtonStyle())
    }
}


struct FavoriteColumn_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteColumn()
    }
}
