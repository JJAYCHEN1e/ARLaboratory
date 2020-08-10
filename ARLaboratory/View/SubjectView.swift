//
//  SubjectView.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/10.
//

import SwiftUI

struct SubjectView: View {
    @State private var selectedSubject = Subject.all
    
    var body: some View {
        ZStack {
            Rectangle()
            .foregroundColor(Color(#colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9607843137, alpha: 0.5)))
            .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(alignment: .center) {
                    Picker("Subject", selection: $selectedSubject) {
                        ForEach(Subject.allCases) { subject in
                            Text(subject.description()).tag(subject)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: CGFloat(Subject.allCases.count) * 100)
                    
                    ForEach(Subject.allCases) { subject in
                        if subject != .all && (selectedSubject == .all || selectedSubject == subject) {
                            SubjectHeadView(title: subject.description(), subtitle: subject.rawValue.capitalized)
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 220), spacing: 24)], spacing: 24) {
                                ForEach(labs.filter(with: subject), id: \.title) {
                                    lab in
                                    SubjectLabCard(title: lab.title, subtitle: lab.subtitle, illustrationImage: lab.illustrationImage, linearGradient: lab.gradient)
                                }
                            }
                            .padding(.vertical)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct SubjectLabCard: View {
    var title: String
    var subtitle: String
    var illustrationImage: String
    var linearGradient: LinearGradient
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(linearGradient)
                    .shadow(color: Color.white.opacity(0.05), radius:3, x:0, y:1)
                    .shadow(color: Color(#colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.8823529412, alpha: 1)).opacity(0.4), radius: 10, x: 0, y: 10)
                
                VStack(alignment: .leading) {
                    Text("\(subtitle)")
                        .font(Font.system(size: 14).weight(.semibold))
                        .foregroundColor(Color.white.opacity(0.8))
                        .padding(.bottom, 0)
                    
                    Text("\(title)")
                        .font(Font.system(size: Int(proxy.size.width / 10) < 26 ? CGFloat(Int(proxy.size.width / 10)) : 26).weight(.semibold))
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    Image("\(illustrationImage)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.blue)
                        .padding(.bottom, 5)
                }
                .padding(.horizontal, 20)
                .padding(.vertical)
            }
        }
        .aspectRatio(1, contentMode: .fill)
        .responsiveButton(action: nil)
    }
}

struct SubjectView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectView()
    }
}
