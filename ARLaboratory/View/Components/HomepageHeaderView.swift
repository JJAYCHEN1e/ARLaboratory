//
//  HomepageHeaderView.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/11/4.
//

import SwiftUI

struct HomepageHeaderView: View {
    @Binding var tabSelection: Int
    var body: some View {

        HStack {
            VStack(spacing: 0) {
                
                HStack{
                    Text("Hi，实验者").font(Font.system(size: 24).weight(.bold)).foregroundColor(.white)
                    Spacer()
                }.padding(.bottom,20).opacity( tabSelection == 3 ? 0 : 1 )
                HStack(){
                    Image("seedlings").resizable().frame(width: 20, height: 19, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(.trailing,5).padding(.leading,1)
                    Text("初中三年级").font(Font.system(size: 15).weight(.bold)).foregroundColor(.white)
                    Image("singleArrow").resizable().frame(width: 12, height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).offset(y:1)
                    Spacer()
                    Text("SloganSloganSloganSloganSloganSloganSlogan")
                        .foregroundColor(.white)
                        .padding(.horizontal,56)
                        .opacity( tabSelection == 3 ? 0 : 1 )
                }
                Spacer()
            }.padding(.top,85).padding(.leading,56)
        }.frame(height: 190)
        
        
        
        
    }
}

struct HomepageHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageHeaderView(tabSelection: .constant(3))
    }
}
