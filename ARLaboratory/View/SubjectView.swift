//
//  SubjectView.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/10.
//

import SwiftUI

struct SubjectView: View {
    @State private var selectedSubject = Subject.all
    @Binding var show: Bool
    
    let cardMinimenSize: CGFloat = screenWidth < 400 ? 135 : 220
    let cardSpacing: CGFloat = screenWidth < 400 ? 16 : 24
    
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
                    .fixedSize()
                    
                    ForEach(Subject.allCases) { subject in
                        if subject != .all && (selectedSubject == .all || selectedSubject == subject) {
                            SubjectHeadView(title: subject.description(), subtitle: subject.rawValue.capitalized)
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: cardMinimenSize), spacing: cardSpacing)], spacing: cardSpacing) {
                                ForEach(labs.filter(with: subject), id: \.title) {
                                    lab in
                                    SubjectLabCard(title: lab.title, subtitle: lab.subtitle, illustrationImage: lab.illustrationImage, linearGradient: lab.gradient)
                                        .onTapGesture {
                                            show.toggle()
                                        }
                                }
                            }
                            .padding(.vertical)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
}

fileprivate struct SubjectLabCard: View {
    var title: String
    var subtitle: String
    var illustrationImage: String
    var linearGradient: LinearGradient
    
    let subtitleFontMaximum: CGFloat = isPhone ? 14 : 16
    let subtitleFontMinimum: CGFloat = isPhone ? 12 : 14
    let titleFontMaximum: CGFloat = isPhone ? 22 : 26
    
    private func subtitleFont(with size: CGSize) -> CGFloat {
        var calculatedSize = size.width / 15
        calculatedSize = (calculatedSize < subtitleFontMaximum) ? calculatedSize : subtitleFontMaximum
        calculatedSize = (calculatedSize < subtitleFontMinimum) ? subtitleFontMinimum : calculatedSize
        
        return calculatedSize
    }
    
    private func titleFont(with size: CGSize) -> CGFloat {
        return (size.width / 10 < titleFontMaximum) ? size.width / 10 : titleFontMaximum
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(linearGradient)
                    .shadow(color: Color.white.opacity(0.05), radius:3, x:0, y:1)
                    .shadow(color: Color(#colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.8823529412, alpha: 1)).opacity(0.4), radius: 10, x: 0, y: 10)
                
                VStack(alignment: .leading) {
                    Text("\(subtitle)")
                        .font(Font.system(size: subtitleFont(with: proxy.size)).weight(.semibold))
                        .foregroundColor(Color.white.opacity(0.8))
                        .padding(.bottom, 0)
                    
                    Text("\(title)")
                        .font(Font.system(size: titleFont(with: proxy.size)).weight(.semibold))
                        .foregroundColor(Color.white)
                        .minimumScaleFactor(0.5)
                    
                    Spacer()
                    
                    Image("\(illustrationImage)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.blue)
                }
                .padding()
            }
        }
        .aspectRatio(1, contentMode: .fill)
        .responsiveButton(action: nil)
    }
}

struct SubjectView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectView(show: .constant(false))
    }
}
