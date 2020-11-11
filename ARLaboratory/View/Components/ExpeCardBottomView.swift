//
//  ExpeCardBottomView.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/10/29.
//

import SwiftUI

struct ExpeCardBottomView: View {
    @State var numberOfProblems: Int
    @State var numberOfCorrectAnswers: Int
    @State var score: Int
    @Binding var showBottom : Bool
    var body: some View {
        VStack(spacing : 0){
            HStack {
                Path{ path in
                    path.move(to: CGPoint(x: 0, y: 2))
                    path.addLine(to: CGPoint(x: 500, y: 2))
                }
                .stroke(style: StrokeStyle( lineWidth: 1, dash: [3,3] ))
                .foregroundColor(Color(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)))
            }.frame( height: 4)
            .clipped()
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    (score < 0 ? Text("首次挑战"): Text("历史成绩"))
                        .font(Font.system(size: 14).weight(.semibold))
                        .foregroundColor(Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1)))
                        .kerning(1.4)
                    (score < 0 ? Text("动动小手，快来试试吧！") : Text("\(numberOfCorrectAnswers) of \(numberOfCorrectAnswers) Problems"))
                        .gradeEffect()
                }
                Spacer()
                if score<=0 {
                    Image("Go").resizable().frame(width: 44, height: 44)
                }else
                {
                    ScoreCircleView(percentage: showBottom ?  CGFloat(score)/100 : CGFloat(0), width: 40, score: score)
                    
                }
            }.padding(.top, 9)
            
            
            
        }
    }
}

struct ExpeCardBottomView_Previews: PreviewProvider {
    static var previews: some View {
        ExpeCardBottomView(numberOfProblems: 8, numberOfCorrectAnswers: 1, score: -1, showBottom: .constant(true))
    }
}


struct gradeModifier: ViewModifier {    
    func body(content : Content) -> some View {
        content.font(Font.system(size: 12).weight(.semibold))
            .foregroundColor(Color(#colorLiteral(red: 0.2039215686, green: 0.262745098, blue: 0.337254902, alpha: 1)))
    }
}

extension View{
    func gradeEffect()-> some View{
        self.modifier(gradeModifier())
    }
}
