//
//  LottieView.swift
//  ARLaboratory
//
//  Created by 陈俊杰 on 11/13/20.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    typealias UIViewType = UIView
    var lottieFileName: String
    var repeatTime: Float
    var completionHandle: () -> Void
    @Binding var play: Bool
    
    init(lottieFileName: String, repeatTime: Float = 1.0, completionHandle: @escaping () -> Void = {}, play: Binding<Bool>) {
        self.lottieFileName = lottieFileName
        self.repeatTime = repeatTime
        self.completionHandle = completionHandle
        self._play = play
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let animationView = AnimationView(name: lottieFileName)
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        return view
    }
    
    func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }

    class Coordinator {
        var control: LottieView
        
        init(_ control: LottieView) {
            self.control = control
        }
        
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if play {
            for view in uiView.subviews where view is AnimationView {
                if let animationView = view as? AnimationView {
                    animationView.loopMode = .repeat(repeatTime)
                    animationView.play(completion: { if $0 {
                        UIView.transition(with: animationView, duration: 0.5, options: .curveEaseInOut, animations: {
                            animationView.alpha = 0
                        }, completion: nil)
                    }})
                }
            }
        }
    }
}
