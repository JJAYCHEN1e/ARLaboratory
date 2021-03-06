//
//  AppDelegate.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/11/12.
//

import Foundation
import UIKit
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        initSqlite()
        return true
    }
    
    func initSqlite(){
        let dbPath = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("ARLaboratory.sqlite")
        
        let db = FMDatabase(url: dbPath)
        
        print(dbPath)
        guard db.open() else {
            print("Unable to open database")
            return
        }
        print("DataBase opened successfully")
        
        do {
            
            if db.tableExists("experiment") {
                try db.executeUpdate("drop table if exists experiment", values: nil)
            }
            
            if db.tableExists("history") {
                try db.executeUpdate("drop table if exists history", values: nil)
            }
            
            //            if !db.tableExists("history"){
            //                try db.executeUpdate("create table history(title TEXT PRIMARY KEY, date DATE)", values: nil)}
            //
            if !db.tableExists("experiment"){
                try db.executeUpdate("create table experiment(title TEXT PRIMARY KEY,subject TEXT,chapter INT,problems INT,correctAnswers INT,score INT,level TEXT,liked INT,column TEXT)", values: nil)
                
                try db.executeUpdate("insert into experiment(title,subject,chapter,correctAnswers,problems,level,score,liked,column) values (?,?,?,?,?,?,?,?,?)",values:["探究凸透镜成像规律","物理", 1 ,0,6,"初中",-1,0,""])

                try db.executeUpdate("insert into experiment(title,subject,chapter,correctAnswers,problems,level,score,liked,column) values (?,?,?,?,?,?,?,?,?)",values:["观察种子细胞","生物",1,0,8,"初中",-1,0,""])
                try db.executeUpdate("insert into experiment(title,subject,chapter,correctAnswers,problems,level,score,liked,column) values (?,?,?,?,?,?,?,?,?)",values:["检测生物组织中的DNA","生物",1,0,8,"高中",-1,0,""])
                try db.executeUpdate("insert into experiment(title,subject,chapter,correctAnswers,problems,level,score,liked,column) values (?,?,?,?,?,?,?,?,?)",values:["血红蛋白的提取和分离","生物", 1 ,0,8,"高中",57,0,""])
                try db.executeUpdate("insert into experiment(title,subject,chapter,correctAnswers,problems,level,score,liked,column) values (?,?,?,?,?,?,?,?,?)",values:["观察洋葱表皮","生物", 1 ,0,8,"高中",76,0,""])
                try db.executeUpdate("insert into experiment(title,subject,chapter,correctAnswers,problems,level,score,liked,column) values (?,?,?,?,?,?,?,?,?)",values:["观察激素对植物生长的影响","生物", 2 ,0,8,"初中",-1,0,""])
                try db.executeUpdate("insert into experiment(title,subject,chapter,correctAnswers,problems,level,score,liked,column) values (?,?,?,?,?,?,?,?,?)",values:["微生物的实验室培养","生物", 1 ,0,8,"高中",-1,0,""])
                try db.executeUpdate("insert into experiment(title,subject,chapter,correctAnswers,problems,level,score,liked,column) values (?,?,?,?,?,?,?,?,?)",values:["基因检测片段","生物", 1 ,0,8,"高中",-1,0,""])
                
                try db.executeUpdate("insert into experiment(title,subject,chapter,correctAnswers,problems,level,score,liked,column) values (?,?,?,?,?,?,?,?,?)",values:["练习使用弹簧秤","物理", 1 ,0,8,"初中",-1,0,""])
                try db.executeUpdate("insert into experiment(title,subject,chapter,correctAnswers,problems,level,score,liked,column) values (?,?,?,?,?,?,?,?,?)",values:["三棱镜分解太阳光实验","物理", 1 ,0,8,"初中",-1,0,""])
                try db.executeUpdate("insert into experiment(title,subject,chapter,correctAnswers,problems,level,score,liked,column) values (?,?,?,?,?,?,?,?,?)",values:["探究望远镜成像原理","物理", 2 ,0,8,"初中",-1,0,""])
                try db.executeUpdate("insert into experiment(title,subject,chapter,correctAnswers,problems,level,score,liked,column) values (?,?,?,?,?,?,?,?,?)",values:["小球碰撞验证动量守恒定律","物理", 2 ,0,8,"初中",90,0,""])
                try db.executeUpdate("insert into experiment(title,subject,chapter,correctAnswers,problems,level,score,liked,column) values (?,?,?,?,?,?,?,?,?)",values:["苹果掉落之探索力的加速度","物理", 1 ,0,8,"初中",-1,0,""])
                
                
                try db.executeUpdate("insert into experiment(title,subject,chapter,correctAnswers,problems,level,score,liked,column) values (?,?,?,?,?,?,?,?,?)",values:["铁锈的制备配比","化学", 1 ,0,8,"初中",-1,0,""])
                try db.executeUpdate("insert into experiment(title,subject,chapter,correctAnswers,problems,level,score,liked,column) values (?,?,?,?,?,?,?,?,?)",values:["气体的制备","化学", 1 ,0,8,"初中",-1,0,""])
                try db.executeUpdate("insert into experiment(title,subject,chapter,correctAnswers,problems,level,score,liked,column) values (?,?,?,?,?,?,?,?,?)",values:["氯化钠溶液的制备与配比","化学", 1 ,0,8,"初中",-1,0,""])
                try db.executeUpdate("insert into experiment(title,subject,chapter,correctAnswers,problems,level,score,liked,column) values (?,?,?,?,?,?,?,?,?)",values:["粗盐提纯","化学", 1 ,0,8,"高中",-1,0,""])
                try db.executeUpdate("insert into experiment(title,subject,chapter,correctAnswers,problems,level,score,liked,column) values (?,?,?,?,?,?,?,?,?)",values:["分子、原子和离子的比较","化学", 1 ,0,8,"初中",-1,0,""])
                try db.executeUpdate("insert into experiment(title,subject,chapter,correctAnswers,problems,level,score,liked,column) values (?,?,?,?,?,?,?,?,?)",values:["化学实验的安全须知","化学", 1 ,0,8,"初中",-1,0,""])
            }
            let rs = try db.executeQuery("select title, subject, level from experiment", values: nil)
            var count = 0
            while rs.next() {
                if let x = rs.string(forColumn: "title"), let y = rs.string(forColumn: "subject"), let z = rs.string(forColumn: "level") {
                    count+=1
                    print("title = \(x); subject = \(y); level = \(z)")
                }
            }
            print(count)
            
            
        }catch{
            print("failed\(error.localizedDescription)")
        }
        db.close()
    }
}

