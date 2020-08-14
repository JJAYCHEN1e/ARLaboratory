//
//  ProblemCard.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/8/11.
//

import SwiftUI


struct ProblemCard: View {
    @State var problemIndex : Int
    @State var experimentName : String
    @State var problem : Problem
    @State var hasPressed : Bool = false
    @State var chosenIndex : Int = -1
    @State var tag : Bool = false
    @Binding var score : Int
    @Binding var offset : Int
    @Binding var correctAnswer : Int
    @Binding var showScore : Bool
    @Binding var circleAnimationStart : Bool
    var countOfProblems : Int
    var body: some View {
        let answerIndex : Int = self.problem.answer

        ZStack {
            HStack {
                Spacer()
                VStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color("secondaryColor"))
                        .overlay(Image("close")
                                    .resizable()
                                    .frame(width: 16, height: 16))
                    Spacer()
                }
            }
            .padding(.trailing , 22)
            .padding(.top , 22)
            .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            ZStack {
                    
                
               
                    
                    
                        VStack {
                            ZStack {
                                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                                    Text("第")
                                        .font(.system(size : 18))
                                        .foregroundColor(Color("primaryColor"))
                                        .padding(.bottom , 2)
                                        
                                    Text("\(problemIndex + 1)")
                                        .font(.system(size : 20))
                                        .foregroundColor(Color("primaryColor"))
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .padding(.bottom , 2)

                                    Text(" /\(countOfProblems)题")
                                        .kerning(1)
                                        .font(.system(size : 18))
                                        .foregroundColor(Color("primaryColor"))

                                }
                                
                                .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                                RoundedRectangle(cornerRadius: 5.5)
                                    .frame(width: 110, height: 11, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color("secondaryColor"))
                                    .zIndex(0)
                                    .offset(y: 8)
                            }
                            .padding(.top,70)
                            .padding(.bottom ,10)


                            Text(experimentName).font(.system(size: 14))
                                .kerning(5)
                                .foregroundColor(Color("primaryColor"))
                                .padding(.bottom, 15)


                            
                            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: true, content: {
                                Text(problem.title)
                                    .font(.system(size : 14))
                                    .font(Font.body.leading(.loose))
                                    .foregroundColor(Color(#colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.4156862745, alpha: 1)))
                                    .fontWeight(.semibold)
                                    .lineSpacing(9)

                            })
                                .padding(.horizontal , 45)
                                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: 1000, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            VStack {
                                HStack {
                                    Text("请在下方选择正确答案")
                                    Spacer()
                                }.padding(.top,20).foregroundColor(Color(#colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.4156862745, alpha: 0.8)))
                                ScrollView(.vertical, showsIndicators: true, content: {
                                    ForEach(problem.choices.indices ,id : \.self){
                                        i in
                                        ChoiceCell(content: problem.choices[i],index: i, selected: !(chosenIndex == -1), isRightAnswer : answerIndex == i,hasPressed: $hasPressed, chosenIndex: $chosenIndex)
                                            .padding(2)
                                        
                                            
                                            
                                    }
                                    .padding(.vertical,2)
                                })
                                .frame(height:210)
                                
                            }.padding(.horizontal,70)
                            
                            Spacer().background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)

                        }.frame(width: 553, height: 625, alignment: .top )
                    VStack {
                        (hasPressed ? ( chosenIndex == answerIndex ? Text("牛逼 对了") : Text("答错了，下次努力")) : Text(""))
                            .padding(.bottom,5)
                        Button(action: {
                            if(hasPressed && !tag){
                                self.tag = true
                                if chosenIndex == answerIndex {
                                    score += 10
                                    correctAnswer += 1
                                }
                                if(offset < countOfProblems)
                                {
                                    offset = offset + 1
                                    
                                }else{
                                    offset = 0
                                }
                                if problemIndex == countOfProblems-1 {
                                    showScore = true
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
        .frame(width: 553, height: 769, alignment: .top)

            
        
    }
}

struct ProblemCard_Previews: PreviewProvider {
    static var previews: some View {
        ProblemCard(problemIndex: 13, experimentName: "小球碰撞验证动量守恒定律", problem: problems[0], score: .constant(0), offset: .constant(0), correctAnswer: .constant(0), showScore: .constant(false), circleAnimationStart: .constant(false), countOfProblems: 14)
    }
}
