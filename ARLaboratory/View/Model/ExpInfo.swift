//
//  ExpInfo.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/10/23.
//

import Foundation
struct ExperimentInfo {
    var subject:String;
    var title:String;
    var image:String;
    var chapter:Int;
    var column:String;
    var liked:Bool = false;
    var numbersOfProblems : Int;
    var numbersOfCorectAnswer: Int;
    var score:Int;
    
}



class GlobalExperiments: ObservableObject {
    @Published var experiments : [ExperimentInfo] = []
    init(){
        self.experiments = fetchDataFromSQLite()
    }
    
    private func fetchDataFromSQLite() -> [ExperimentInfo]{
        let dbPath = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("ARLaboratory.sqlite")
        
        let db = FMDatabase(url: dbPath)
        
        print(dbPath)
        guard db.open() else {
            print("Unable to open database")
            return []
        }
        var tmp: [ExperimentInfo] = []
        
        do{
            let rs = try db.executeQuery("select title, subject, chapter, problems, correctAnswers, liked, score, column from experiment", values: nil)
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
    
    func likeAnExperiment(title : String, nextLikedState : Bool){
        
        let dbPath = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("ARLaboratory.sqlite")
        let db = FMDatabase(url: dbPath)
        print(dbPath)
        guard db.open() else {
            print("Unable to open database")
            return
        }
        print("DataBase opened successfully")
        let willLiked: Int = nextLikedState ? 1 : 0
        do{
            try db.executeUpdate("update experiment set liked = \(willLiked) where title = \""+title+"\"", values: nil)
            print("update successfully")
        }catch{
            print("failed\(error.localizedDescription)")
        }
        db.close()
        
        for i in 0..<experiments.count{
            if experiments[i].title == title {
                experiments[i].liked = nextLikedState
                break
            }
        }
        return
        
    }
    
    func fetchDataForSubject(subject: String)-> [ExperimentInfo]{
        var tmp: [ExperimentInfo] = []
        for experiment in experiments {
            if experiment.subject == subject {
                tmp.append(experiment)
            }
        }
        return tmp
    }
    
}


