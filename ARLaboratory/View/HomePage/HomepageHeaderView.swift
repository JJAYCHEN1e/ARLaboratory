//
//  HomepageHeaderView.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/11/4.
//

import SwiftUI

struct HomepageHeaderView: View {
    var body: some View {
        HStack {
            Image("mainBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: .infinity).overlay(
                        VStack(spacing: 0) {
                            HStack {
                                Image("avatar").resizable().frame(width: 38, height: 38).overlay(RoundedRectangle(cornerRadius: 19).stroke(Color(#colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.9843137255, alpha: 1)),lineWidth: 1))
                                Spacer()
                            }.padding(.bottom,15)
                            HStack{
                                Text("Hi，实验者").font(Font.system(size: 24).weight(.bold)).foregroundColor(.white)
                                Spacer()
                            }.padding(.bottom,20)
                            HStack(){
                                Image("seedlings").resizable().frame(width: 20, height: 19, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(.trailing,5).padding(.leading,1)
                                Text("初中三年级").font(Font.system(size: 15).weight(.bold)).foregroundColor(.white)
                                Image("singleArrow").resizable().frame(width: 12, height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).offset(y:1)
                                Spacer()
                                Text("SloganSloganSloganSloganSloganSloganSlogan")
                                    .foregroundColor(.white)
                                    .padding(.horizontal,56)
                                
                            }
                            Spacer()
                    }.padding(.top,60).padding(.leading,56))
        }.frame(height: 220)
            
            
            
        
    }
}

struct HomepageHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageHeaderView()
    }
}
