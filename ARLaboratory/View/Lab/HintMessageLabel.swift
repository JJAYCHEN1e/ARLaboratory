//
//  HintMessageLabel.swift
//  ARPlayground
//
//  Created by 陈俊杰 on 11/5/20.
//

import SwiftUI

protocol HasTextModel: ObservableObject {
    var text: String { get set }
}

struct HintMessageLabel<Model: HasTextModel>: View {
    @State var tag: Int = 0
    @State var isHidden = true
    @ObservedObject var textModel: Model
    
    var body: some View {
        Text(textModel.text)
            .multilineTextAlignment(.center)
            .padding()
            .foregroundColor(Color.white.opacity(0.8))
            .background(
                Blur()
            )
            .cornerRadius(15)
            .frame(maxWidth: 350)
            .animation(.none)
            .opacity(textModel.text.isEmpty || isHidden ? 0 : 1)
            .animation(Animation.easeInOut(duration: 0.5))
            .onChange(of: textModel.text, perform: { value in
                // Unfortunately, now, we can't trigger this if we give same text twice otherwise we set
                // text to a temporary value and then change it.
//                print("onChange: \(value)")
                if !value.isEmpty {
//                    print("1111")
                    isHidden = false
                    tag = tag + 1
                    let capturedTag = tag
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        // Do not hide if this method is called again before this block kicks in.
//                        print("\(self.tag), \(capturedTag)")
                        if self.tag == capturedTag {
                            self.isHidden = true
                        }
                    }
                }
            })
    }
}

//fileprivate struct HintMessageLabelModifier: ViewModifier {
//    @Binding var text: String
//    
//    func body(content: Content) -> some View {
//        ZStack(alignment: .top) {
//            content
//            HintMessageLabel(text: $text)
//                .padding(.top)
//        }
//    }
//}
//
//extension View {
//    func hintMessageLabel(text: Binding<String>) -> some View {
//        self.modifier(HintMessageLabelModifier(text: text))
//    }
//}


struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemThinMaterialDark
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
