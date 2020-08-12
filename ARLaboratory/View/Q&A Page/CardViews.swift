//
//  CardViews.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/8/11.
//

import SwiftUI

struct CardViews: View {
    var body: some View {
        ZStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            ProblemCard(problem: problems[0]).scaleEffect(x:0.93,y: 0.85 ,anchor: .center).offset(x: 58).opacity(0.4)
            ProblemCard(problem: problems[0]).scaleEffect(x:0.98,y: 0.93 ,anchor: .center).offset(x: 27).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            ProblemCard(problem: problems[0])
            
  

        }
    }
}

struct CardViews_Previews: PreviewProvider {
    static var previews: some View {
        CardViews()
    }
}
