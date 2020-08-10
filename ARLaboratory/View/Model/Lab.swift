//
//  Lab.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/10.
//

import Foundation
import SwiftUI

struct Lab {
    enum Grade: String {
        case 初中
        case 高中
    }
    
    var title: String
    var grade: Grade
    var subject: Subject
    var performance: CGFloat? = nil
    var illustrationImage: String
    var gradient: LinearGradient
    
    var subtitle: String {
        grade.rawValue + subject.description()
    }
    
    var rawTitle: String {
        title.replacingOccurrences(of: "\n", with: "")
    }
}

let labs = [
    Lab(title: "小球碰撞\n验证动量守恒定律", grade: .高中, subject: .physics, performance: 82,illustrationImage: "illustrations_momentum", gradient: linearGradients[0]),
    Lab(title: "探究凸透镜\n成像规律", grade: .初中, subject: .physics, illustrationImage: "illustrations_convex", gradient: linearGradients[1]),
    Lab(title: "化学分子\n晶体模型展示", grade: .高中, subject: .chemistry, illustrationImage: "illustrations_cell", gradient: linearGradients[2]),
    Lab(title: "杨氏双缝\n干涉实验", grade: .高中, subject: .physics, performance: 95,illustrationImage: "illustrations_double-slit", gradient: linearGradients[3]),
    Lab(title: "认识太阳系\n行星轨道模型", grade: .初中, subject: .physics, illustrationImage: "illustrations_solar", gradient: linearGradients[4]),
    Lab(title: "认识常见\n化学实验设备", grade: .高中, subject: .chemistry, illustrationImage: "illustrations_equipment", gradient: linearGradients[5]),
    Lab(title: "观察种子\n的结构", grade: .初中, subject: .biology, illustrationImage: "illustrations_seed", gradient: linearGradients[6]),
]

private let linearGradients = [
    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8, green: 0.6823529412, blue: 0.9647058824, alpha: 1)), Color(#colorLiteral(red: 0.4156862745, green: 0.368627451, blue: 0.9568627451, alpha: 1))]),
                   startPoint: UnitPoint(x: 0.3, y: -0.1),
                   endPoint: UnitPoint(x: 0.8, y: 1.1)),
    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.7443302274, blue: 0.4703813195, alpha: 1)), Color(#colorLiteral(red: 0.9647058824, green: 0.5019607843, blue: 0.5019607843, alpha: 1))]),
                   startPoint: UnitPoint(x: 0, y: 0),
                   endPoint: .bottomTrailing),
    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9568627451, green: 0.9176470588, blue: 0.8862745098, alpha: 1)), Color(#colorLiteral(red: 0.4274509804, green: 0.6117647059, blue: 0.7529411765, alpha: 1))]),
                   startPoint: UnitPoint(x: 0, y: -0.5),
                   endPoint: .bottomTrailing),
    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5254901961, green: 0.7450980392, blue: 0.8784313725, alpha: 1)), Color(#colorLiteral(red: 0.2392156863, green: 0.3333333333, blue: 0.8588235294, alpha: 1))]),
                   startPoint: .top,
                   endPoint: .bottomTrailing),
    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9764705882, green: 0.6078431373, blue: 0.7843137255, alpha: 1)), Color(#colorLiteral(red: 0.9058823529, green: 0.431372549, blue: 0.5960784314, alpha: 1))]),
                   startPoint: .top,
                   endPoint: .bottomTrailing),
    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9960784314, green: 0.6705882353, blue: 0.6078431373, alpha: 1)), Color(#colorLiteral(red: 0.9411764706, green: 0.3215686275, blue: 0.431372549, alpha: 1))]),
                   startPoint: .top,
                   endPoint: .bottomTrailing),
    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4588235294, green: 0.8156862745, blue: 0.5882352941, alpha: 1)), Color(#colorLiteral(red: 0.5490196078, green: 0.7529411765, blue: 0.2156862745, alpha: 1))]),
                   startPoint: .topLeading,
                   endPoint: .bottomTrailing),
]

extension Array where Element == Lab{
    func filter(with subject: Subject) -> [Element] {
        self.filter({ $0.subject == subject})
    }
}
