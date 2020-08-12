//
//  ChoiceCell.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/8/11.
//

import SwiftUI

struct ChoiceCell: View {
    @State var content : String
    var isTure: Bool = true
    
    var body: some View {
            HStack {
                Text(content)
                Spacer()
                (isTure ? Image("correct") : Image("fault"))
                    .resizable()
                    .frame(width: 18, height: 18)
                    
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 9)
                        .stroke(
                            Color(#colorLiteral(red: 0.8352941176, green: 0.8352941176, blue: 0.9647058824, alpha: 1)),lineWidth: 2.5)
                        )
        



        
    }
}

struct ChoiceCell_Previews: PreviewProvider {
    static var previews: some View {
        ChoiceCell(content: "Test")
    }
}

