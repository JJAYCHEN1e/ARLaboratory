//
//  SubjectHeadView.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/10.
//

import SwiftUI

struct SubjectHeadView: View {
    var title: String
    var subtitle: String
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                Text("\(subtitle)")
                    .fontWeight(.bold)
                    .font(.title)
                Text("\(title)")
                    .fontWeight(.medium)
                    .font(Font.largeTitle)
                
            }
            .foregroundColor(.primaryColor)
            
            Spacer()
        }
    }
}

struct SubjectHeadView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectHeadView(title: "物理", subtitle: "Physics")
    }
}
