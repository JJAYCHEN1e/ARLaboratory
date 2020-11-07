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
                ScoreCircleView(percentage: showBottom ?  CGFloat(score)/100 : CGFloat(0), width: 40, score: score)
            }.padding(.top, 9)
            
            
            
        }
    }
}

struct ExpeCardBottomView_Previews: PreviewProvider {
    static var previews: some View {
        ExpeCardBottomView(numberOfProblems: 8, numberOfCorrectAnswers: 1, score: -1, showBottom: .constant(true))
    }
}

struct ScoreCircleView: View {
   var percentage: CGFloat
   var width : CGFloat
   var score: Int
   var body: some View {
       ZStack {
           Circle()
               .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5))
               .frame(width: width, height: width)
           
           Circle()
               .trim(from: 0.0, to: percentage)
               .stroke(
                   LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7730026841, green: 1, blue: 0.9720677733, alpha: 1)), Color(#colorLiteral(red: 0.5450980392, green: 0.3960784314, blue: 0.9490196078, alpha: 0.66))]), startPoint: .bottomTrailing, endPoint: .topLeading),
                   style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0)
               )
               .rotationEffect(Angle(degrees: -90))
               .frame(width: width, height: width)
               .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.1), radius: 3, x: 0, y: 3)
        (score < 0 ? Text("Go") : Text("\(score)"))
               .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8)))
            .font(Font.system(size: 14).weight(.semibold))
               .fontWeight(.bold)
       }
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
