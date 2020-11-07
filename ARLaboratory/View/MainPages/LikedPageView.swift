//
//  LikedPageView.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/11/6.
//

import SwiftUI
import NavigationStack
struct LikedPageView: View {
    @EnvironmentObject private var navigationStack: NavigationStack
    var body: some View {
        let experiments: [ExperimentInfo] = queryLiked()
        ZStack {
            VStack {
                Image("backgroundCandidate")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(1.01)
                Spacer()
            }.ignoresSafeArea()
            VStack {
                ZStack{
                    HStack {
                        Image("back").resizable().frame(width: 48, height: 48)
                        Spacer()
                    }.padding(.horizontal,45).onTapGesture(perform: {
                        self.navigationStack.pop()
                    })
                    Text("收藏").font(Font.system(size: 27).weight(.semibold)).foregroundColor(.white).kerning(1).shadow(color: Color(#colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 0.32)), radius: 4, x: 0, y: 2)
                }.padding(.bottom,10).frame(height: 101)
                TopRoundedRectangleView().overlay(
                    
                    
                    VStack {
                        
                        if(experiments.count == 0){
                            Image("noLikes").resizable().frame(width: 223, height: 130).padding(.top, 150)
                            Text("/ *  这里空空如也  * /").font(Font.system(size: 14).weight(.bold)).foregroundColor(Color(#colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.6823529412, alpha: 1))).kerning(2).padding(.top, 50)
                            Spacer()
                        }else{
                            VStack{
                                SubtitleComponent(str: "我的收藏").padding(.horizontal,18)
                                Spacer()
                                ScrollView(showsIndicators: false){
                                    ForEach(experiments, id: \.self.title){ experiment in
                                        Button(action: {}) {
                                            RoundedRectangle(cornerRadius: 16).foregroundColor(.white).shadow(color: Color(#colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1)), radius: 15, x: 0, y: 2).overlay(
                                                HStack(spacing: 20){
                                                    Image(experiment.image).resizable().frame(width: 100, height: 100).clipShape(RoundedRectangle(cornerRadius: 15))
                                                    VStack(alignment: .leading, spacing: 4){
                                                        Text(experiment.title).font(Font.system(size: 16).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.3294117647, green: 0.4078431373, blue: 1, alpha: 1)))
                                                        Text("花点时间学生物").font(Font.system(size: 22).weight(.semibold)).kerning(1).foregroundColor(Color(#colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.4156862745, alpha: 1))).lineLimit(1).frame(height: 28)
                                                        Spacer(minLength: 0)
                                                        Text("第\(experiment.chapter)章节").font(Font.system(size: 15)).kerning(1).foregroundColor(Color(#colorLiteral(red: 0.2039215686, green: 0.262745098, blue: 0.337254902, alpha: 1)))
                                                    }.padding(.vertical,22)
                                                    Spacer()
                                                    RoundedRectangle(cornerRadius: 18).frame(width: 110, height: 36).foregroundColor(Color(#colorLiteral(red: 0.8352941176, green: 0.831372549, blue: 1, alpha: 1))).overlay(Text("立即学习").font(Font.system(size: 16)).fontWeight(.semibold).kerning(2).foregroundColor(Color(#colorLiteral(red: 0.1647058824, green: 0.1568627451, blue: 0.8, alpha: 1)))).padding()
                                                }.padding(.horizontal,18)
                                                
                                            ).frame(height: 130)
                                        }.padding(.horizontal).padding(.vertical,3).buttonStyle(ResponsiveButtonStyle())
                                    }
                                }
                                
                            }.padding(.top, 50).padding(.horizontal,40)
                            
                        }
                    }
                )
            }
            
        }.onAppear()
        
    }
    
    
    
    func queryLiked()-> [ExperimentInfo]{
        let dbPath = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("ARLaboratory.sqlite")
        
        let db = FMDatabase(url: dbPath)
        
        print(dbPath)
        guard db.open() else {
            print("Unable to open database")
            return []
        }
        var tmp: [ExperimentInfo] = []
        
        do{
            let rs = try db.executeQuery("select title, subject, chapter, problems, correctAnswers, score, column from experiment where liked = \"1\"", values: nil)
            print( "Sucessful Query!!!")
            while rs.next() {
                let subject : String = rs.string(forColumn: "subject") ?? ""
                let title:String = rs.string(forColumn: "title") ?? ""
                let image:String = title
                let chapter:Int  = Int(rs.int(forColumn: "chapter"))
                let liked: Bool = true
                let numbersOfProblems = Int(rs.int(forColumn: "problems"))
                let numbersOfCorectAnswer = Int(rs.int(forColumn: "correctAnswers"))
                let column: String = rs.string(forColumn: "column") ?? ""
                let score = Int(rs.int(forColumn: "score"))
                tmp.append(ExperimentInfo(subject: subject, title: title, image: image, chapter: chapter, column: column, liked: liked, numbersOfProblems: numbersOfProblems, numbersOfCorectAnswer: numbersOfCorectAnswer, score: score ))
                print(title)
            }
            
        }catch{
            print("failed\(error.localizedDescription)")
        }
        db.close()
        return tmp
    }
}

struct LikedPageView_Previews: PreviewProvider {
    static var previews: some View {
        LikedPageView()
    }
}
