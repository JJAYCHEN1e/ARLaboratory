//
//  ExpInfo.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/10/23.
//

import Foundation
struct ExperimentInfo {
    var subject:Subject;
    var title:String;
    var image:String;
    var chapter:Int;
    var column:String;
    var liked:Bool = false;
    var numbersOfProblems : Int;
    var numbersOfCorectAnswer: Int;
    var score:Int? = nil;
    
}


let exps0 = [ExperimentInfo(subject: .physics, title: "探究小球碰撞验证动量守恒", image: "物理实验图例", chapter: 1, column: "物理", numbersOfProblems: 8, numbersOfCorectAnswer: 0),
             ExperimentInfo(subject: .physics, title: "探究小球碰撞验证动量守恒", image: "化学实验图例", chapter: 1, column: "化学", numbersOfProblems: 8, numbersOfCorectAnswer: 0),
             ExperimentInfo(subject: .physics, title: "探究小球碰撞验证动量守恒", image: "物理实验图例", chapter: 1, column: "物理", numbersOfProblems: 8, numbersOfCorectAnswer: 0),
             ExperimentInfo(subject: .physics, title: "探究小球碰撞验证动量守恒", image: "物理实验图例", chapter: 1, column: "物理", numbersOfProblems: 8, numbersOfCorectAnswer: 0),
             ExperimentInfo(subject: .physics, title: "探究小球碰撞验证动量守恒", image: "物理实验图例", chapter: 1, column: "物理", numbersOfProblems: 8, numbersOfCorectAnswer: 0),
             ExperimentInfo(subject: .physics, title: "探究小球碰撞验证动量守恒", image: "物理实验图例", chapter: 1, column: "物理", numbersOfProblems: 8, numbersOfCorectAnswer: 0)];

let exps1 = [ExperimentInfo(subject: .physics, title: "探究小球碰撞验证动量守恒", image: "物理实验图例", chapter: 1, column: "物理", numbersOfProblems: 8, numbersOfCorectAnswer: 0),
             ExperimentInfo(subject: .physics, title: "探究小球碰撞验证动量守恒", image: "物理实验图例", chapter: 1, column: "物理", numbersOfProblems: 8, numbersOfCorectAnswer: 0),
             ExperimentInfo(subject: .physics, title: "探究小球碰撞验证动量守恒", image: "物理实验图例", chapter: 1, column: "物理", numbersOfProblems: 8, numbersOfCorectAnswer: 0),
             ExperimentInfo(subject: .physics, title: "探究小球碰撞验证动量守恒", image: "物理实验图例", chapter: 1, column: "物理", numbersOfProblems: 8, numbersOfCorectAnswer: 0),
             ExperimentInfo(subject: .physics, title: "探究小球碰撞验证动量守恒", image: "物理实验图例", chapter: 1, column: "物理", numbersOfProblems: 8, numbersOfCorectAnswer: 0),
             ExperimentInfo(subject: .physics, title: "探究小球碰撞验证动量守恒", image: "物理实验图例", chapter: 1, column: "物理", numbersOfProblems: 8, numbersOfCorectAnswer: 0)];

let exps2 = [ExperimentInfo(subject: .physics, title: "探究小球碰撞验证动量守恒", image: "物理实验图例", chapter: 1, column: "物理", numbersOfProblems: 8, numbersOfCorectAnswer: 0),
             ExperimentInfo(subject: .physics, title: "探究小球碰撞验证动量守恒", image: "物理实验图例", chapter: 1, column: "物理", numbersOfProblems: 8, numbersOfCorectAnswer: 0),
             ExperimentInfo(subject: .physics, title: "探究小球碰撞验证动量守恒", image: "物理实验图例", chapter: 1, column: "物理", numbersOfProblems: 8, numbersOfCorectAnswer: 0),
             ExperimentInfo(subject: .physics, title: "探究小球碰撞验证动量守恒", image: "物理实验图例", chapter: 1, column: "物理", numbersOfProblems: 8, numbersOfCorectAnswer: 0),
             ExperimentInfo(subject: .physics, title: "探究小球碰撞验证动量守恒", image: "物理实验图例", chapter: 1, column: "物理", numbersOfProblems: 8, numbersOfCorectAnswer: 0),
             ExperimentInfo(subject: .physics, title: "探究小球碰撞验证动量守恒", image: "物理实验图例", chapter: 1, column: "物理", numbersOfProblems: 8, numbersOfCorectAnswer: 0)];
