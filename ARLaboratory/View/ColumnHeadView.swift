//
//  ColumnHeadView.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/8.
//

import SwiftUI

struct ColumnHeadView: View {
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
            
            VStack(alignment: .trailing) {
                Button {
                    
                } label: {
                    VStack(alignment: .trailing) {
                        Image(systemName: "chevron.right")
                            .font(Font.body.bold())
                            .padding()
                            .background(Circle().fill(Color.secondaryColor))
                            .cornerRadius(1000)
                            .shadow(color: Color.secondaryColor.opacity(0.4), radius: 5.0, x: 0.0, y: 7.0)
                            .shadow(color: Color.black.opacity(0.05), radius: 1.0, x: 0.0, y: 1.0)
                        Text("查看更多")
                            .font(Font.body.weight(.medium))
                            .offset(y: -2)
                    }
                    .foregroundColor(.primaryColor)
                }
            }
        }
        
    }
}

struct ColumnHeadView_Previews: PreviewProvider {
    static var previews: some View {
        ColumnHeadView(title: "今日推荐", subtitle: "Today")
    }
}
