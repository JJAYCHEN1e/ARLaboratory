//
//  SubtitleComponent.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/11/4.
//

import SwiftUI

struct SubtitleComponent: View {
    var str:String
    var fontSize: CGFloat = 25
    var body: some View {
        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
            RoundedRectangle(cornerRadius: 6).frame(width: 10, height: 24).foregroundColor(Color(#colorLiteral(red: 0.3882352941, green: 0.3843137255, blue: 0.9254901961, alpha: 1))).padding(.trailing,10)
            Text(str).font(Font.system(size: fontSize).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.2745098039, green: 0.2705882353, blue: 0.737254902, alpha: 1)))
            Spacer()
        }
    }
}

struct SubtitleComponent_Previews: PreviewProvider {
    static var previews: some View {
        SubtitleComponent(str: "测试测试")
    }
}
