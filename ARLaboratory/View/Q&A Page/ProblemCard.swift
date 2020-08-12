//
//  ProblemCard.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/8/11.
//

import SwiftUI


struct ProblemCard: View {
    @State var problem : Problem
    @State var hasPressed : Bool = false
    @State var chosenIndex : Int = -1
    @Binding var score : Int
    @State var tag : Bool = false
    var body: some View {
        let answerIndex : Int = self.problem.answer

            ZStack {
                    VStack {
                        Text("物理的新题目").font(.system(size: 28)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(Color("primaryColor"))
                            .padding(.top,70)
                            .padding(.bottom, 30)
                        
                        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: true, content: {
                            Text(problem.title)
                                .font(Font.body.leading(.loose))
                                .foregroundColor(Color(#colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.4156862745, alpha: 1)))
                                .fontWeight(.semibold)
                                .lineSpacing(9)

                        })
                            .padding(.horizontal , 25)
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: 800, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        HStack {
                            Text("请在下方选择正确答案")
                            Spacer()
                        }.padding(.horizontal,50).padding(.top,20).foregroundColor(Color(#colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.4156862745, alpha: 0.8)))
                        ScrollView(.vertical, showsIndicators: true, content: {
                            ForEach(problem.choices.indices ,id : \.self){
                                i in
                                ChoiceCell(content: problem.choices[i],index: i, selected: !(chosenIndex == -1), isRightAnswer : answerIndex == i,hasPressed: $hasPressed, chosenIndex: $chosenIndex)
                                    .padding(.vertical,2)
                                    
                                    
                            }
                            .padding(.horizontal).padding(.vertical,2)
                        }).padding(.horizontal,32).frame(height:252)
                        
                    }.frame(width: 553, height: 625, alignment: .top )
                VStack {
                    (hasPressed ? ( chosenIndex == answerIndex ? Text("牛逼 对了") : Text("答错了，下次努力")) : Text(""))
                        .padding(.bottom,5)
                    Button(action: {
                        if(hasPressed && !tag){
                            self.tag = true
                            if chosenIndex == answerIndex {
                                score += 10
                            }
                        }
                        
                    }) {
                        Text("下一题")
                            .foregroundColor(.white)
                            .frame(width: 298, height: 44)
                            .background(
                                
                                (chosenIndex != -1) ?
                                Color(#colorLiteral(red: 0.2745098039, green: 0.2745098039, blue: 0.8549019608, alpha: 1)):Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            .cornerRadius(12)
                            .shadow(color:  (chosenIndex != -1) ?
                                        Color(#colorLiteral(red: 0.2745098039, green: 0.2745098039, blue: 0.8549019608, alpha: 1)) : Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), radius: 0.5, x: 0, y: 2)
                    }
                    

                }
                .offset(x: 0, y: 360)
                            }
            .frame(width: 553, height: 769, alignment: .top)
            .cornerRadius(9)
            .background(
                RoundedRectangle(cornerRadius: 9)
                    .foregroundColor(.white)                            .shadow(color: Color(#colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 0.82)), radius: 8, x: 2, y: 2).blur(radius: 0.2))
            
        
    }
}

struct ProblemCard_Previews: PreviewProvider {
    static var previews: some View {
        ProblemCard(problem: problems[0], score: .constant(0))
    }
}
