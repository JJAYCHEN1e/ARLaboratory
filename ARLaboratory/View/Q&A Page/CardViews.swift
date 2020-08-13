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
            Text(String.init(offset))
            ZStack {
                ProblemCard(problem: problems[0], score: $score).selectModifier(offset: offset+3)
                ProblemCard(problem: problems[0], score: $score).selectModifier(offset: offset+2)
                ProblemCard(problem: problems[0], score: $score).selectModifier(offset: offset+1)
                ProblemCard(problem: problems[0], score: $score).selectModifier(offset: offset)
            }
            Button(action: {
                offset = offset + 1
            } ) {
                Text("测试").foregroundColor(.white)
                    .frame(width: 298, height: 44)
                    .background(Color(#colorLiteral(red: 0.2745098039, green: 0.2745098039, blue: 0.8549019608, alpha: 1)))
                    .cornerRadius(12)
            }
            }

            
        }
    }




extension View{
    func selectModifier(offset : Int) -> some View{
        switch (offset%4) {
        case 0:
            return self.modifier(firstCard())
        case 1:
            return self.modifier(secondCard())
        case 2:
            return self.modifier(thirdCard())
        default:
            return self.modifier(candidateCard())

        }
            
        
    }
}
struct CardViews_Previews: PreviewProvider {
    static var previews: some View {
        CardViews()
    }
}

struct firstCard : ViewModifier {
    
    func body(content : Content) -> some View {
        content.zIndex(4.0)
        
    }
}

struct secondCard : ViewModifier {
    
    func body(content : Content) -> some View {
        content.scaleEffect(x:0.98,y: 0.93 ,anchor: .center).offset(x: 27).opacity(0.9).zIndex(3.0)
        
    }
}

struct thirdCard : ViewModifier {
    
    func body(content : Content) -> some View {
        content.scaleEffect(x:0.93,y: 0.85 ,anchor: .center).offset(x: 58).opacity(0.3).zIndex(2.0)
        
    }
}

struct candidateCard : ViewModifier {
    
    func body(content : Content) -> some View {
        content.scaleEffect(x:0.93,y: 0.78 ,anchor: .center).offset(x: 70).opacity(0).zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
        
    }
}
