//
//  CardViews.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/8/11.
//

import SwiftUI


struct CardViews: View {
    @State var score : Int = 0
    @State var offset : Int = 0
    var body: some View {
        
        VStack {
            Text(String.init(score))
            ZStack {
                ProblemCard(problem: problems[0], score: $score).scaleEffect(x:0.93,y: 0.85 ,anchor: .center).offset(x: 58).opacity(0.3)
                ProblemCard(problem: problems[0], score: $score).scaleEffect(x:0.98,y: 0.93 ,anchor: .center).offset(x: 27).opacity(0.9)
                ProblemCard(problem: problems[0], score: $score)
                
      

            }
        }
    }
}

struct CardViews_Previews: PreviewProvider {
    static var previews: some View {
        CardViews()
    }
}
