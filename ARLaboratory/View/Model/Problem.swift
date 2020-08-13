//
//  File.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/8/11.
//

import Foundation
struct Problem : Identifiable{
    let id = UUID();
    let title : String;
    let answer: Int;
    let choices: [String];
    
}


let problems  = [
    Problem(title:"在高速公路上发生一起交通事故，一辆质量为15000kg向南行驶的客车迎面撞上了一辆质量为3000kg向北行驶的卡车，碰后两车接在一起，并向南滑行了一段距离后停止。根据测速仪的测定，长途客车碰前以20m/s的速度行驶，由此可判断卡车碰前行驶速率为（ ）？在高速公路上发生一起交通事故，一辆质量为15000kg向南行驶的客车迎面撞上了一辆质量为3000kg向北行驶的卡车，碰后两车接在一起，并向南滑行了一段距离后停止。根据测速仪的测定，长途客车碰前以20m/s的速度行驶，由此可判断卡车碰前行驶速率为（ ）？在高速公路上发生一起交通事故，一辆质量为15000kg向南行驶的客车迎面撞上了一辆质量为3000kg向北行驶的卡车，碰后两车接在一起，并向南滑行了一段距离后停止。根据测速仪的测定，长途客车碰前以20m/s的速度行驶，由此可判断卡车碰前行驶速率为（ ）？", answer: 1, choices: ["小于10m/s","大于10m/s","小于20m/s","大于20m/s","ceshiceshiceshi","ceshiceshiceshi","ceshiceshiceshi"]),
    Problem(title:"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试", answer: 1, choices: ["小于10m/s","大于10m/s","小于20m/s","大于20m/s","ceshiceshiceshi","ceshiceshiceshi","ceshiceshiceshi"]),
    Problem(title:"啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊）？在高速公路上发生一起交通事故，一辆质量为15000kg向南行驶的客车迎面撞上了一辆质量为3000kg向北行驶的卡车，碰后两车接在一起，并向南滑行了一段距离后停止。根据测速仪的测定，长途客车碰前以20m/s的速度行驶，由此可判断卡车碰前行驶速率为（ ）？", answer: 1, choices: ["小于10m/s","大于10m/s","小于20m/s","大于20m/s","ceshiceshiceshi","ceshiceshiceshi","ceshiceshiceshi"]),
    Problem(title:"南行驶的客车迎面撞上了一辆质量为3000kg向北行驶的卡车，碰后两车接在一起，并向南滑行了一段距离后停止。根据测速仪的测定，长途客车碰前以20m/s的速度行驶，由此可判断卡车碰前行驶速率为（ ）？", answer: 1, choices: ["小于10m/s","大于10m/s","小于20m/s","大于20m/s","ceshiceshiceshi","ceshiceshiceshi","ceshiceshiceshi"]),
    
]
