//
//  ScoreView.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/8/14.
//

import SwiftUI

struct ScoreView: View {
    @Binding var correctAnswers : Int
    @State var experimentName : String
    @State var countOfProblems : Int
    @Binding var showScoreCard : Bool
    @Binding var circleAnimationStart : Bool
    @State var twinkle : Bool = false
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center)
        ) {
            Image("scoreViewBackground")
                .resizable()
                
                Image("Medal")
                    .resizable()
                    .frame(width: twinkle ? 100 : 127, height: twinkle ? 122 : 155, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .opacity(twinkle ? 0.7 : 1)
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .onReceive(timer) { _ in
                        self.twinkle.toggle()
                    }.offset(y : -230)
            
            
            VStack {
               

                
                
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                                Text("答对了")
                                    .font(.system(size : 18))
                                    .foregroundColor(Color("primaryColor"))
                                    .padding(.bottom , 2)
                                    
                                Text("\(correctAnswers)")
                                    .font(.system(size : 20))
                                    .foregroundColor(Color("primaryColor"))
                                    .fontWeight(.bold)
                                    .padding(.bottom , 2)

                                Text(" /\(countOfProblems)题")
                                    .kerning(1)
                                    .font(.system(size : 18))
                                    .foregroundColor(Color("primaryColor"))
                    }.padding(.top, 8)
                Text(experimentName)
                    .foregroundColor(Color("primaryColor"))
                    .kerning(6)
                    .font(.system(size: 14))
                    .padding(.top , 6)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,154)
                    
                Text("祝贺")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .kerning(16)
                    .frame(width: 155, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 36))
                    .foregroundColor(Color("primaryColor"))
                    .padding(.top,9)
                HStack {
                    Text("You did a good job in the test！")
                        .fontWeight(.semibold)
                        .font(.system(size: 16))
                        .foregroundColor(Color(#colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.4156862745, alpha: 0.55)))
                        .padding(.top,8)
                        .lineLimit(1)
                    Spacer()
                }            .padding(.horizontal , 154)

                
                HStack {
                    Text("您的得分情况：")
                        .kerning(7)
                        .fontWeight(.regular)
                        .foregroundColor(Color(#colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.4156862745, alpha: 0.72)))
                        .font(.system(size: 16))
                        .padding(.top, 5)
                    Spacer()
                }
                .padding(.horizontal , 154)

                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 275, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(#colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.968627451, alpha: 0.4)))
                    .overlay(
                        HStack{
                            VStack(alignment: .leading , spacing: 0){
                                Text("自我测验成绩")
                                    .kerning(0.6)
                                    .font(.system(size: 15))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(#colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.4156862745, alpha: 1)))
                                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                                Text("\(Date(),formatter: dateFormatter)")
                                    .kerning(0.4)
                                    .font(.system(size: 10))
                                    .foregroundColor(Color(#colorLiteral(red: 0.02745098039, green: 0.02745098039, blue: 0.4470588235, alpha: 1)))
                                    .fontWeight(.semibold)
                            }
                            .padding(.leading,18)
                            .padding(.vertical,12)
                            Spacer()
                            RingView(percentage: showScoreCard ? (CGFloat(correctAnswers)/CGFloat(countOfProblems)) : 0, width: 44, score: Int((CGFloat(correctAnswers)/CGFloat(countOfProblems))*100))
                                .animation(
                                    Animation.interpolatingSpring(mass: 1, stiffness: 100, damping: 30, initialVelocity: 7)
                                        .delay(0.6)
                                )
                                .padding(16)
                                
                    })
                
                Text("在本次测试中，您表现的非常好。\n通过本次测试，你可以基本掌握动能守恒定律，实验基本操作以及基本计算。")
                    .padding(.horizontal , 154)
                    .padding(.top,5)
                    .lineSpacing(3)
                    .font(.system(size: 8))
                    .foregroundColor(Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 0.6)))
            }
            .padding(.top ,251)
            .frame(width: 553, height: 769, alignment: .top)
            
            HStack {
                Spacer()
                VStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 30, height: 30, alignment: .center)
                        .foregroundColor(Color("secondaryColor"))
                        .overlay(Image("close")
                                    .resizable()
                                    .frame(width: 16, height: 16))
                    Spacer()
                }
            }
            .padding(.trailing , 22)
            .padding(.top , 22)
            .zIndex(1.0)
        }.frame(width: 553, height: 769, alignment: .top)
        .cornerRadius(9)
        .background(
            RoundedRectangle(cornerRadius: 9)
            .foregroundColor(.white)                            .shadow(color: Color(#colorLiteral(red: 0.5176470588, green: 0.5176470588, blue: 0.5176470588, alpha: 0.82)), radius: 8, x: 2, y: 2).blur(radius: 0.2)
                )
//        .onAppear(perform: {
//
//        })
    }
}



var dateFormatter : DateFormatter{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    return formatter
}


struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(correctAnswers: .constant(14), experimentName:"小球碰撞验证动量守恒定律ssssssss", countOfProblems: 14, showScoreCard:
                    .constant(true), circleAnimationStart: .constant(false)
 )
    }
}
