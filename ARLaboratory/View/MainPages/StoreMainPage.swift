//
//  StoreMainPage.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/11/4.
//

import SwiftUI

struct StoreMainPage: View {
    @State var chosenIndex : Int = 1
   
    var body: some View {
        let experiments : [ExperimentInfo] = updateData(chosenIndex: chosenIndex)
        VStack {
            HStack(spacing: 12){
                Image("physics").resizable()
                    .chosenEffect(chosenIndex: chosenIndex, selfIndex: 1)
                    .onTapGesture(perform: {
                        withAnimation(.spring(response: 0.39, dampingFraction: 0.55, blendDuration: 0.4), {chosenIndex = 1})
                    })
                Image("chemistry").resizable()
                    .chosenEffect(chosenIndex: chosenIndex, selfIndex: 2)
                    .onTapGesture(perform: {
                        withAnimation(.spring(response: 0.39, dampingFraction: 0.55, blendDuration: 0.4), {chosenIndex = 2})
                    })
                Image("biology").resizable()
                    .chosenEffect(chosenIndex: chosenIndex, selfIndex: 3)
                    .onTapGesture(perform: {
                        withAnimation(.spring(response: 0.39, dampingFraction: 0.55, blendDuration: 0.2), {chosenIndex = 3})
                    })
                Spacer()
                
                
            }.padding(.horizontal,53)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 225)),GridItem(.adaptive(minimum: 225)),GridItem(.adaptive(minimum: 225))], alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                    ForEach(experiments, id: \.self.title){ experiment in
                        ExperimentCardView(title: experiment.title, subject: decodeSubject(subject: experiment.subject), chapter: experiment.chapter, image: experiment.image, column: "", numbersOfProblems: experiment.numbersOfProblems, numbersOfCorrectAnswers: experiment.numbersOfCorectAnswer, score: experiment.score, showBottom: true, liked: experiment.liked, showArrow: false)
                                            }
                }.padding(.horizontal ,30).padding(.bottom, 40)
            }.padding(.horizontal,23)
        }
    }
    
    func decodeSubject(subject: String)-> String{
        switch subject {
        case "物理":
            return "物理 - Physics"
        case "化学":
            return "化学 - Chemistry"
        default:
            return "生物 - Biology"
        }
    }
    
    
    func updateData(chosenIndex: Int)-> [ExperimentInfo]{
        let dbPath = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("ARLaboratory.sqlite")
        
        let db = FMDatabase(url: dbPath)
        
        print(dbPath)
        guard db.open() else {
            print("Unable to open database")
            return []
        }
        var tmp: [ExperimentInfo] = []

        do{
            let rs = try db.executeQuery("select title, subject, chapter, problems, correctAnswers, liked, score, column from experiment where subject ="+"\""+index2Subject(index: chosenIndex)+"\"", values: nil)
                print( "Sucessful Query!!!")
            while rs.next() {
                let subject : String = rs.string(forColumn: "subject") ?? ""
                let title:String = rs.string(forColumn: "title") ?? ""
                let image:String = title
                let chapter:Int  = Int(rs.int(forColumn: "chapter"))
                let liked: Bool = rs.bool(forColumn: "liked")
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

struct StoreMainPage_Previews: PreviewProvider {
    static var previews: some View {
        StoreMainPage()
    }
}

func index2Subject(index : Int) -> String {
    switch index {
    case 1:
        return  "物理"
    case 2:
        return  "化学"
    default:
        return  "生物"
    }
}



struct chosenEffectModifier : ViewModifier {
    var chosen : Bool
    func body(content: Content) -> some View {
        content
            .frame(width: chosen ? 115 :  96, height:chosen ? 51 : 42)
            .shadow(color: chosen ? Color(#colorLiteral(red: 0.1764705882, green: 0.1764705882, blue: 0.6823529412, alpha: 0.2)) : Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: chosen ? 16 : 0, x:  2, y: 2)
        
    }
}
extension View{
    func chosenEffect(chosenIndex: Int, selfIndex : Int) -> some View{
        self.modifier(chosenEffectModifier(chosen: chosenIndex == selfIndex))
    }
}



