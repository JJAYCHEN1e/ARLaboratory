//
//  ImportColumn.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/13.
//

import SwiftUI

struct ImportColumn: View {
    var body: some View {
        HStack {
            NewImportCard()
        }
        .padding(.horizontal)
        .padding(.top)
        .padding(.bottom, 24)
    }
}

struct NewImportCard: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .strokeBorder(style: StrokeStyle(
                            lineWidth: 2,
                            dash: [5]))
            .foregroundColor(Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 0.6)))
            .frame(width: 140, height: 140)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color(#colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1)))
            )
            .overlay(
                VStack(spacing: 0) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 44))
                    VStack {
                        Text("导入场景")
                            .font(.system(size: 16, weight: .medium))
                            .padding(.top, 5)
                    }
                    
                }
                .foregroundColor(Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 0.6)))
            )
    }
}

struct ImportColumn_Previews: PreviewProvider {
    static var previews: some View {
        ImportColumn()
    }
}
