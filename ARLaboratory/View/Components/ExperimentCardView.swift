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
    @State var scaleCofficient: CGFloat = 1.0
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
                            Text(subject)
                                .font(Font.system(size: 14).weight(.semibold))
                                .foregroundColor(Color(#colorLiteral(red: 0.3294117647, green: 0.4078431373, blue: 1, alpha: 1)))
                                .padding(.vertical, 4)
                            HStack(alignment: .bottom) {
                                Text(title)
                                    .foregroundColor(Color(#colorLiteral(red: 0.2039215686, green: 0.262745098, blue: 0.337254902, alpha: 1)))
                                    .font(Font.system(size: 20).weight(.semibold))
                                    .lineSpacing(3)
                                    .lineLimit(2)
                                    .frame(height: showArrow ? nil : 52)
                                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                                RoundedRectangle(cornerRadius: 11).frame(width: 50,height: 22).foregroundColor(liked ? Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)) : Color(#colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1))).overlay(
                                        ZStack{
                                            Text("已收藏")
                                                .font(Font.system(size: 11).weight(.semibold)).kerning(1).frame(width: 50, height: 22, alignment: .center)
                                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
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
                                                    clickLike()
                                                  })
                                })
                                
                            }.padding(.vertical,1)
                            
                        }
                        
                        
                        ExpeCardBottomView(numberOfProblems: numbersOfProblems, numberOfCorrectAnswers: numbersOfCorrectAnswers, score: score, showBottom: $showBottom).padding(.top,7).opacity(showBottom ? 1 : 0)
                            .frame(height: showBottom ? nil : 0)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom, showArrow ? 0 : 14)
                        if(showArrow) {
                            
                            Image("arrow").resizable().frame(width: 18, height: 24, alignment: .center)
                                .rotationEffect(showBottom ? .degrees(180) : .degrees(360))
                                .onTapGesture(perform: {withAnimation(
                                    .easeOut(duration: 0.3)
                                    ,
                                    {
                                        showBottom.toggle()
                                        
                                    })
                                })
                            
                        }
                    }
                    .padding(.horizontal, 13)
                    
                }
                .onTapGesture(perform: {
                    navigationStack.push(ExperimentIntroPageview(title: title, subject: subject))
                })
                .frame(width: 225, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .cornerRadius(25)
                .padding(.vertical,13)
                .shadow(color: Color(#colorLiteral(red: 0.2352941176, green: 0.5019607843, blue: 0.8196078431, alpha: 0.09)), radius: 15, x: 0, y: 4)
                .scaleEffect(scaleCofficient)
        }
//        .onTapGesture(perform: {
//            withAnimation(.easeOut, {self.scaleCofficient = 0.9})
//        })
//        .gesture(
//            TapGesture().onEnded({ _ in self.scaleCofficient = 1})
//        )
        
        
        
    }
    func clickLike(){
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
    
}

struct ExperimentCardView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentCardView(title: "气体的制备制备制备制备制备制", subject: "生物 - Biology", chapter: 1, image: "化学实验图例", column: "", numbersOfProblems: 1, numbersOfCorrectAnswers: 8, score: -1, showBottom: true, liked: false, showArrow: true)
    }
}


