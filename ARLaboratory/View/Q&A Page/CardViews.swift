//
//  CardViews.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/8/11.
//

import SwiftUI

class ViewTypeInfo {
    var scaleX : Double
    var scaleY : Double
    var offsetX: Int
    var opacity: Double
    var zIndex: Int
    init(scaleX : Double,scaleY : Double,offsetX: Int,opacity: Double,zIndex: Int) {
        self.scaleX = scaleX
        self.scaleY = scaleY
        self.offsetX = offsetX
        self.opacity = opacity
        self.zIndex = zIndex
    }
}


struct CardViews: View {
    @State var score : Int = 0
    @State var offset : Int = 0
    @State var experimentName : String
    var body: some View {
        
        VStack {
            Text(String.init(score))
            Text(String.init(offset))
            ZStack {
                ForEach(problems.indices,id : \.self){ i in
                    let viewTypeInfo = selectViewType(offset: i - offset)
                    ProblemCard(problemIndex: i, experimentName: experimentName, problem: problems[(i+offset)%4], score: $score, offset: $offset)
                        .scaleEffect(x: CGFloat(viewTypeInfo.scaleX), y: CGFloat(viewTypeInfo.scaleY), anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .offset(x: CGFloat(viewTypeInfo.offsetX), y: 0)
                        .opacity(viewTypeInfo.opacity)
                        .zIndex(Double(viewTypeInfo.zIndex))
                }
            }
           
            }
        .animation(.easeInOut)


            
        }
    }


func selectViewType(offset : Int) -> ViewTypeInfo {
    switch offset {
    case 0:
        return first
    case 1:
        return second
    case 2:
        return third
    default:
        if offset < 0 {
            return candidateBig
        }
        return candidateSmall
    }
}



let candidateSmall = ViewTypeInfo(scaleX: 0.93, scaleY: 0.78, offsetX: 70, opacity: 0, zIndex: 1)
let first = ViewTypeInfo(scaleX: 1, scaleY: 1, offsetX: 0, opacity: 1, zIndex: 4)
let second = ViewTypeInfo(scaleX: 0.98, scaleY: 0.93, offsetX: 27, opacity: 0.9, zIndex: 3)
let third = ViewTypeInfo(scaleX: 0.93, scaleY: 0.85, offsetX: 58, opacity: 0.3, zIndex: 2)
let candidateBig = ViewTypeInfo(scaleX: 1.1, scaleY: 1.1, offsetX: -50, opacity: -1, zIndex: 5)


struct CardViews_Previews: PreviewProvider {
    static var previews: some View {
        CardViews( experimentName: "小球碰撞验证动量守恒定律")
    }
}

