//
//  ChoiceCell.swift
//  ARLaboratory
//
//  Created by 徐滔锴 on 2020/8/11.
//

import SwiftUI

struct ChoiceCell: View {
    var content : String
    var index : Int
    @State var selected: Bool = false
    @State var isRightAnswer: Bool = false
    @Binding var hasPressed : Bool
    @State var imageStr : String = "unselected"
    @Binding var chosenIndex : Int

    var body: some View {
            
       
        
   
            HStack {
                    Text(content)
                        .font(.system(size: 13))
                    Spacer()
                    (hasPressed ? (isRightAnswer ? Image("correct") : selected ? Image("false") : Image("unselected")) : Image("unselected"))
                        .resizable()
                        .frame(width: 17, height: 17)
                        
                }
                .padding(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 9)
                            .stroke(
                                (hasPressed ? (isRightAnswer ? Color(#colorLiteral(red: 0.2745098039, green: 0.2745098039, blue: 0.8549019608, alpha: 1)) : selected ? Color(#colorLiteral(red: 0.8745098039, green: 0.5019607843, blue: 0.7450980392, alpha: 1)) : Color(#colorLiteral(red: 0.8352941176, green: 0.8352941176, blue: 0.9647058824, alpha: 1))) : Color(#colorLiteral(red: 0.8352941176, green: 0.8352941176, blue: 0.9647058824, alpha: 1))),lineWidth: 2.5)
            )
            .background(Color.white)
            .onTapGesture{
                print("1")
                withAnimation(){
                    if(!hasPressed){
                        hasPressed = true
                        selected = true
                        chosenIndex = index
                        
                    }
                    
                }
            }
        
           
           



        
    }
}

struct ChoiceCell_Previews: PreviewProvider {
    static var previews: some View {
        ChoiceCell(content: "Test", index: 0,hasPressed: .constant(false), imageStr: "unselected", chosenIndex: .constant(0))
    }
}


struct unselected : ViewModifier {
    func body(content: Content) -> some View {
           content
               
       }
}

