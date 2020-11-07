//
//  ScorePageView.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/11/7.
//

import SwiftUI
import NavigationStack


struct ScorePageView: View {
    @EnvironmentObject private var navigationStack : NavigationStack
    var body: some View {
        let experiments: [ExperimentInfo] = queryScores()
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
                    Text("排行榜").font(Font.system(size: 27).weight(.semibold)).foregroundColor(.white).kerning(1).shadow(color: Color(#colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 0.32)), radius: 4, x: 0, y: 2)
                }.padding(.bottom,10).frame(height: 101)
                TopRoundedRectangleView().overlay(
                    
                    VStack {
                        
                        if(experiments.count == 0){
                            Image("noScores").resizable().frame(width: 193, height: 142).padding(.top, 150)
                            Text("/ *  快去开始第一次挑战吧！  * /").font(Font.system(size: 14).weight(.bold)).foregroundColor(Color(#colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.6823529412, alpha: 1))).kerning(2).padding(.top, 50)
                            Spacer()
                        
                            
                            
                        }else{
                            VStack(spacing : 10){
                                SubtitleComponent(str: "我的成绩").padding(.horizontal,18).padding(.horizontal, 20)
                                ScrollView(showsIndicators: false){
                                    VStack {
                                        ForEach(0..<experiments.count, id: \.self){ index in
                                            let experiment = experiments[index]
                                            HStack {
                                                Text(serializeIndex(index: index)).kerning(2)
                                                    .font(.custom("NotoSansKannada-Bold", size: 32, relativeTo: .body)).foregroundColor(index < 3 ? Color(#colorLiteral(red: 0.9137254902, green: 0.5529411765, blue: 0.737254902, alpha: 1)) : Color(#colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1))).padding(.bottom, 3)
                                                
                                                Button(action: {}) {
                                                    ZStack {
                                                            RoundedRectangle(cornerRadius: 16).foregroundColor(.white).shadow(color: Color(#colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1)), radius: 15, x: 0, y: 2).overlay(
                                                                HStack(spacing: 20){
                                                                    VStack(alignment: .leading, spacing: 4){
                                                                        Text(decodeSubject(subject: experiment.subject)).font(Font.system(size: 16).weight(.semibold)).foregroundColor(Color(#colorLiteral(red: 0.3294117647, green: 0.4078431373, blue: 1, alpha: 1)))
                                                                        Text(experiment.title).font(Font.system(size: 22).weight(.semibold)).kerning(1).foregroundColor(Color(#colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.4156862745, alpha: 1))).lineLimit(1).frame(height: 28).padding(.top, 4)
                                                                        Spacer(minLength: 0)
                                                                        Text("第 \(experiment.chapter) 章节").font(Font.system(size: 15)).kerning(1).foregroundColor(Color(#colorLiteral(red: 0.2039215686, green: 0.262745098, blue: 0.337254902, alpha: 1)))
                                                                    }.padding(.vertical,22).padding(.leading, 84)
                                                                    Spacer()
                                                                    ScoreCircleView(percentage: CGFloat(experiment.score)/100, width: 65, score: experiment.score, innerLineWidth: 3.5, outerLineWidth: 7, fontSize: 20, shadowOffsetX: 7, shadowOffsetY: -4, shadowRadius: 7).padding(20)
                                                                }.padding(.horizontal,18)

                                                            ).padding(.leading, 10).frame(height: 130)
                                                            
                                                            HStack {
                                                                Image(experiment.image).resizable().aspectRatio(contentMode: .fill).frame(width: 100, height: 100).clipShape(RoundedRectangle(cornerRadius: 15)).offset(x: -20)
                                                                Spacer()
                                                            }.padding(.leading,10)
                                                        }
                                                }.padding(.horizontal).padding(.vertical,7).buttonStyle(ResponsiveButtonStyle())
                                            }.padding(.leading, 20)
                                        }
                                    }.padding(.vertical,20)
                                }
                                Spacer(minLength: 0)

                            }.padding(.top, 60).padding(.horizontal,55)
                            
                        }
                    }
                )
            }
            
        }
    }
    
    
    func serializeIndex(index: Int) -> String {
        if index<9 {
            return "0\(index + 1)"
        }else if index < 99 {
            return "\(index+1)"
        }
        return ""
    }
    
    func queryScores()-> [ExperimentInfo]{
        let dbPath = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("ARLaboratory.sqlite")
        
        let db = FMDatabase(url: dbPath)
        
        print(dbPath)
        guard db.open() else {
            print("Unable to open database")
            return []
        }
        var tmp: [ExperimentInfo] = []
        
        do{
            let rs = try db.executeQuery("select title, subject, chapter, problems, correctAnswers, score, column from experiment where score != -1 order by score limit 100", values: nil)
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

struct ScorePageView_Previews: PreviewProvider {
    static var previews: some View {
        ScorePageView()
    }
}
