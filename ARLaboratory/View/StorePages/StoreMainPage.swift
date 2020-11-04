//
//  StoreMainPage.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/11/4.
//

import SwiftUI

struct StoreMainPage: View {
    var body: some View {
        VStack {
            HStack(spacing: 12){
                Image("physics").resizable().frame(width: 115, height: 51, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).shadow(color: Color(#colorLiteral(red: 0.1764705882, green: 0.1764705882, blue: 0.6823529412, alpha: 0.2)), radius: 16, x: 2, y: 2)
                Image("chemistry").resizable().frame(width: 96, height: 42, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Image("biology").resizable().frame(width: 96, height: 42, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            
            
        }.padding(.horizontal,53)
    }
}

struct StoreMainPage_Previews: PreviewProvider {
    static var previews: some View {
        StoreMainPage()
    }
}
