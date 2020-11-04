//
//  ExperimentCardView.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/10/28.
//

import SwiftUI
struct ExperimentCardView: View {
    @State var showBottom: Bool
    @State var liked: Bool
    var showArrow: Bool
    var body: some View {
        VStack{
                    Image("化学实验图例")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 225)
                        .fixedSize(horizontal: true, vertical: true)
                        .clipped()
            VStack(alignment: .center,spacing: 0){
                VStack(alignment: .leading, spacing: 0) {
                            Text("生物 - biology")
                                .font(Font.system(size: 14).weight(.semibold))
                                .foregroundColor(Color(#colorLiteral(red: 0.3294117647, green: 0.4078431373, blue: 1, alpha: 1)))
                                .padding(.vertical, 4)
                            HStack(alignment: .bottom) {
                                Text("气体的制备")
                                    .foregroundColor(Color(#colorLiteral(red: 0.2039215686, green: 0.262745098, blue: 0.337254902, alpha: 1)))
                                    .font(Font.system(size: 20).weight(.semibold))
                                    .lineSpacing(3)
                                    .lineLimit(2)
                                Spacer()
                                RoundedRectangle(cornerRadius: 11).frame(width: 50,height: 22).foregroundColor(liked ? Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)) : Color(#colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1))).overlay(
                                   ZStack{
                                    
                                    
                                    Text("已收藏")
                                        .font(Font.system(size: 11).weight(.semibold)).kerning(1).frame(width: 50, height: 22, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                        .opacity(liked ? 0.7 : 0)		
                                        
                                    Text("收藏")
                                        .font(Font.system(size: 12).weight(.semibold))
                                        .kerning(2)
                                        .frame(width: 50, height: 22, alignment: .center)
                                        .foregroundColor(Color(#colorLiteral(red: 0.4352941176, green: 0.4352941176, blue: 0.4352941176, alpha: 1)))
                                        .opacity(liked ? 0 : 1)
                                    
                                    
                                    
                                   }
                                ).onTapGesture( perform: {
                                    withAnimation(.easeInOut, {liked.toggle()})
                                })
                                
                            }                                    .padding(.vertical,1)

                        }

                                            
                    ExpeCardBottomView(score: .constant(89), showBottom: $showBottom).padding(.top,7).opacity(showBottom ? 1 : 0)
                        .frame(height: showBottom ? nil : 0)
                        .fixedSize(horizontal: false, vertical: true)
                    
                if(showArrow) {
                    Image("arrow").resizable().frame(width: 18, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .rotationEffect(showBottom ? .degrees(180) : .degrees(360))
                                .onTapGesture(perform: {withAnimation(
    //                                .spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.9)
                                    .easeInOut(duration: 0.3)
                                    ,
                                                  {
                                                    showBottom.toggle()
                                                    
                                                  })
                            })
                }
                    }
                    .padding(.horizontal, 13)
 
                }
                .frame(width: 225, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .cornerRadius(25)
        .padding(.vertical,13)
                .shadow(color: Color(#colorLiteral(red: 0.2352941176, green: 0.5019607843, blue: 0.8196078431, alpha: 0.09)), radius: 19, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 12)
//                .animation(.easeInOut)
            
            
            
    }
}

struct ExperimentCardView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentCardView(showBottom: true, liked: false, showArrow: true)
    }
}

