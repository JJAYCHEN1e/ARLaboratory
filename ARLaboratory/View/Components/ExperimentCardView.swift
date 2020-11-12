//
//  ExperimentCardView.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/10/28.
//


import NavigationStack
import SwiftUI
struct ExperimentCardView: View {
    @EnvironmentObject private var navigationStack: NavigationStack
    @ObservedObject private var experiments =  GlobalExperiments()
    @State var title: String
    @State var subject: String
    @State var chapter: Int
    @State var image: String
    @State var column: String
    @State var numbersOfProblems: Int
    @State var numbersOfCorrectAnswers: Int
    @State var score: Int
    @State var showBottom: Bool
    @State var liked: Bool
    var showArrow: Bool
    var body: some View {
        
        
        HStack {
            
                VStack{
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 225,height: showArrow ? nil : 200)
                        .fixedSize(horizontal: true, vertical: true)
                        .clipped()
                    VStack(alignment: .center,spacing: 0){
                        VStack(alignment: .leading, spacing: 0) {
                            if column == "" {
                                Text(decodeSubject(subject: subject))
                                    .font(Font.system(size: 14).weight(.semibold))
                                    .foregroundColor(Color(#colorLiteral(red: 0.3294117647, green: 0.4078431373, blue: 1, alpha: 1)))
                                    .padding(.vertical, 4).padding(.bottom,4)
                            }else{
                                HStack(spacing: 3){
                                    Image("columnTag").resizable().frame(width: 18, height: 18)
                                    Text("专栏").kerning(2).font(Font.system(size: 16)).foregroundColor(Color(#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1)))
                                    Text("@"+column).kerning(1).font(Font.system(size: 16)).foregroundColor(Color(#colorLiteral(red: 0.3882352941, green: 0.3843137255, blue: 0.9254901961, alpha: 1)))
                                    Spacer()

                                }.padding(.bottom, 4).padding(.vertical, 3)
                            }
                            HStack(alignment: .bottom) {
                                Text(title)
                                    .foregroundColor(column == "" ? Color(#colorLiteral(red: 0.2039215686, green: 0.262745098, blue: 0.337254902, alpha: 1)) : Color(#colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.4156862745, alpha: 1)))
                                    .font(Font.system(size: 20).weight(.semibold))
                                    .lineSpacing(3)
                                    .lineLimit(2)
                                    .frame(height: column == "" ? (showArrow ? nil : 52) : nil)
                                    .multilineTextAlignment(column == "" ?  .leading : .center)
                                
                                if column == "" {
                                    Spacer(minLength: 0)
                                    RoundedRectangle(cornerRadius: 11).frame(width: 50,height: 22).foregroundColor(liked ? Color(#colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)) : Color(#colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1))).overlay(
                                        ZStack{
                                            Text("已收藏")
                                                .font(Font.system(size: 11).weight(.semibold)).kerning(1).frame(width: 50, height: 22, alignment: .center)
                                                .foregroundColor(Color(#colorLiteral(red: 0.4352941176, green: 0.4352941176, blue: 0.4352941176, alpha: 1)))
                                                .opacity(liked ? 0.7 : 0)
                                            Text("收藏")
                                                .font(Font.system(size: 12).weight(.semibold))
                                                .kerning(2)
                                                .frame(width: 50, height: 22, alignment: .center)
                                                .foregroundColor(Color(#colorLiteral(red: 0.4352941176, green: 0.4352941176, blue: 0.4352941176, alpha: 1)))
                                                .opacity(liked ? 0 : 1)
                                    }
                                ).onTapGesture(perform: {
                                    withAnimation(.easeInOut(duration: 0.4),
                                                  {
                                                    liked.toggle()
                                                    experiments.likeAnExperiment(title: title, nextLikedState: liked)
                                                  })
                                })
                                }
                            }.padding(.vertical,1)
                            
                        }
                        
                        
                        if column == ""{ExpeCardBottomView(numberOfProblems: numbersOfProblems, numberOfCorrectAnswers: numbersOfCorrectAnswers, score: score, showBottom: $showBottom).padding(.top,7).opacity(showBottom ? 1 : 0)
                            .frame(height: showBottom ? nil : 0)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom, showArrow ? 0 : 14)}else{
                                Button(action: {}){
                                    VStack {
                                        HStack {
                                            Path{ path in
                                                path.move(to: CGPoint(x: 0, y: 2))
                                                path.addLine(to: CGPoint(x: 500, y: 2))
                                            }
                                            .stroke(style: StrokeStyle( lineWidth: 1, dash: [3,3] ))
                                            .foregroundColor(Color(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)))
                                        }.frame( height: 4)
                                        .clipped()
                                        RoundedRectangle(cornerRadius: 15).frame(width: 150, height: 30).foregroundColor(Color(#colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1))).overlay(Text("加入学习").kerning(4).font(Font.system(size: 14)).fontWeight(.bold)).foregroundColor(Color(#colorLiteral(red: 0.4352941176, green: 0.4352941176, blue: 0.4352941176, alpha: 1)))
                                            .padding(.bottom,17).padding(.top,3)
                                    }.padding(.top, 5)
                                }
                            }
                        if(showArrow) {
                            
                            Image("arrow").resizable().frame(width: 18, height: 24, alignment: .center)
                                .rotationEffect(showBottom ? .degrees(180) : .degrees(360))
                                .onTapGesture(perform: {withAnimation(
                                    .easeOut(duration: 0.3)
                                    ,
                                    {
                                        showBottom.toggle()
                                        
                                    })
                                }).padding(.top, 3)
                            
                        }
                    }
                    .padding(.horizontal, 13)
                    
                }
                .onTapGesture(perform: {
                    navigationStack.push(ExperimentIntroPageview(liked: liked, title: title, subject: subject))
                })
                .frame(width: 225, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .cornerRadius(25)
                .padding(.vertical,13)
                .shadow(color: Color(#colorLiteral(red: 0.2352941176, green: 0.5019607843, blue: 0.8196078431, alpha: 0.09)), radius: 15, x: 0, y: 4)
        }

        
    }

}

struct ExperimentCardView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentCardView(title: "气体的制备", subject: "生物 - Biology", chapter: 1, image: "化学实验图例", column: "物理", numbersOfProblems: 1, numbersOfCorrectAnswers: 8, score: -1, showBottom: false, liked: false, showArrow: false)
    }
}


func clickLike(liked : Bool, title: String){
    let dbPath = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("ARLaboratory.sqlite")
    
    let db = FMDatabase(url: dbPath)
    
    print(dbPath)
    guard db.open() else {
        print("Unable to open database")
        return
    }
    print("DataBase opened successfully")
    
    let willLiked: Int = liked ? 1 : 0
    
    do{
        try db.executeUpdate("update experiment set liked = \(willLiked) where title = \""+title+"\"", values: nil)
        print("update successfully")
    }catch{
        print("failed\(error.localizedDescription)")
    }
    db.close()
}
