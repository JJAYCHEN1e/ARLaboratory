//
//  ContentView.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/6.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ColumnHeadView(title: "今日推荐", subtitle: "Today")
                .padding(.horizontal, 24)
                .padding(.vertical)
            RecommandColumn()
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
