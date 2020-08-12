//
//  LatexTextView.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 2020/8/8.
//

import SwiftUI
import iosMath
import YYText

struct LatexTextView: View {
    @State private var width: CGFloat?
    @State private var height: CGFloat?
    var text: String
    
    var fontSize: CGFloat
    var fontColor: UIColor
    
//    var textFontSize: CGFloat
//    var textFontColor: UIColor = UIColor.black
//
//    private var _latexFontSize: CGFloat?
//    var latexFontSize: CGFloat {
//        get { _latexFontSize ?? textFontSize }
//        set { _latexFontSize = newValue }
//
//    }
//
//    private var _latexFontColor: UIColor?
//    var latexFontColor: UIColor {
//        get { _latexFontColor ?? textFontColor }
//        set { _latexFontColor = newValue }
//
//    }
    
    init(text: String, fontSize: CGFloat = 17.0, fontColor: UIColor = UIColor.black) {
        self.text = text
        self.fontSize = fontSize
        self.fontColor = fontColor
    }
    
    var body: some View {
        ZStack {
            InnerLatexTextView(text: text, fontSize: fontSize, fontColor: fontColor, width: $width, height: $height)
                .frame(width: width ?? nil, height: height ?? nil)
            Text(" ")
                .font(.system(size: fontSize))
                .opacity(0)
        }
    }
}

fileprivate struct InnerLatexTextView: UIViewControllerRepresentable {
    private var text: String
    private var fontSize: CGFloat
    private var fontColor: UIColor
    
    private var font: UIFont {
        .systemFont(ofSize: fontSize)
    }
    
    @Binding var width: CGFloat?
    @Binding var height: CGFloat?
    
    init(text: String, fontSize: CGFloat, fontColor: UIColor, width: Binding<CGFloat?>, height: Binding<CGFloat?>) {
        self.text = text
        self.fontSize = fontSize
        self.fontColor = fontColor
        self._width = width
        self._height = height
    }
    
    typealias UIViewControllerType = UIViewController
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, text: text)
    }
    
    class Coordinator: UIViewController {
        private let mathTextContentLeft: CGFloat = 14.0
        private let mathTextContentRight: CGFloat = 14.0
        
        private var innerLatexTextView: InnerLatexTextView
        
        init(_ innerLatexTextView: InnerLatexTextView, text: String) {
            self.innerLatexTextView = innerLatexTextView
            super.init(nibName: nil, bundle: nil)
            setMathText(text: text)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        /// Just for didSet invoke in init.
        private func setMathText(text: String) {
            mathText = text
        }
        
        private var mathText = "" {
            didSet {
                let delimiter = "\\$"
                
                let result: [String] = "\(delimiter).*?\(delimiter)".regularMatchedSubstrings(in: mathText)
                
                let text = NSMutableAttributedString(string: mathText, attributes: [NSAttributedString.Key.font : innerLatexTextView.font])
                
                if result.count > 0 {
                    for item in result {
                        let range: NSRange = (text.string as NSString).range(of: item)
                        if range.location != NSNotFound {
                            let label = createMathUILabel(latex: item.replacingOccurrences(of: "$", with: ""))
                            let attachment = NSMutableAttributedString.yy_attachmentString(withContent: label, contentMode: .center, attachmentSize: label.frame.size, alignTo: innerLatexTextView.font, alignment: .center)
                            text.replaceCharacters(in: range, with: attachment)
                        }
                    }
                }
                mathTextLabel.attributedText = text
            }
        }
        
        private lazy var mathTextLabel: YYLabel = {
            let label = YYLabel()
            label.numberOfLines = 0
            label.preferredMaxLayoutWidth = screenWidth - mathTextContentLeft - mathTextContentRight
            label.textColor = innerLatexTextView.fontColor
            label.font = innerLatexTextView.font
            return label
        }()
        
        
        private func createMathUILabel(latex: String) -> MTMathUILabel {
            let label = MTMathUILabel()
            label.labelMode = .text
            label.textAlignment = .center
            label.fontSize = innerLatexTextView.fontSize
            label.textColor = innerLatexTextView.fontColor
            label.latex = latex
            label.sizeToFit()
            return label
        }
        
        override func viewDidLoad() {
            view = mathTextLabel
        }
        
        override func viewWillAppear(_ animated: Bool) {
            view.sizeToFit()
            innerLatexTextView.width = view.frame.width
            innerLatexTextView.height = view.frame.height
        }
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        context.coordinator
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        return
    }
}

fileprivate extension String {
    func regularMatchedSubstrings(in string: String) -> [String] {
        do {
            let regex: NSRegularExpression = try NSRegularExpression(pattern: self, options: [])
            let matches = regex.matches(in: string, options: [], range: NSMakeRange(0, string.count))
            
            var data = [String]()
            for item in matches {
                let string = (string as NSString).substring(with: item.range)
                data.append(string)
            }
            
            return data
        }
        catch {
            return []
        }
    }
}

struct LatexTextView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 0) {
                LabIntroHeadView(lab: labs.first!)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("实验目标")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primaryColor)
                            .padding(.vertical, 12)
                            .padding(.leading, 60)
                            .padding(.trailing, 24)
                            .background(
                                Capsule()
                                    .foregroundColor(Color(#colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 1, alpha: 1)))
                                    
                                
                            )
                            .overlay(
                                HStack {
                                    Circle()
                                        .frame(width: 40)
                                        .foregroundColor(Color(#colorLiteral(red: 0.2745098039, green: 0.2745098039, blue: 0.8549019608, alpha: 1)))
                                        .overlay(
                                            Text("1")
                                                .font(.title3)
                                                .foregroundColor(.white)
                                        )
                                    Spacer()
                                }
                            )
                        
                        LatexTextView(text: "自然界中存在着三大守恒定律，它们分别是动量守恒定律，能量守恒定律以及角动量守恒定律。它们一起成为现代物理学中的三大基本守恒定律。其中，动量守恒定律描述为：在一个系统中，如果没有任何外力做功，那么该系统中各个物体的动量之和一定是守恒的。如果只有两个物体 $m_1$ 和 $m_2$，那么有，在一段时间前后满足：")
                    }
                    
                    Spacer()
                }
                .padding(.all, 40)
                
                Spacer()
            }
        }
    }
}
