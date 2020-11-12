//
//  DistanceLabelView.swift
//  ceshi
//
//  Created by 陈俊杰 on 11/7/20.
//

import SwiftUI

protocol HasDistanceLabelViewInfo: ObservableObject {
    var startPoint: CGPoint { get set }
    var endPoint: CGPoint { get set }
    var distance: Float { get set }
    var focus: Float { get}
}

struct DistanceLabelView<Model: HasDistanceLabelViewInfo>: View {
    @ObservedObject var model: Model
    
    var centerPoint: CGPoint {
        get {
            CGPoint(x: (model.startPoint.x + model.endPoint.x) / 2,
                    y: (model.startPoint.y + model.endPoint.y) / 2)
        }
    }
    
    var radians: CGFloat {
        get {
            atan((model.endPoint.y - model.startPoint.y) / (model.endPoint.x - model.startPoint.x))
        }
    }
    
    static func calculateHintLabel(focus: Float, distance: Float) -> String {
        if distance < focus {
            return "<f"
        } else if focus <= distance, distance < focus * 2.05 / 1.05 {
            return "(f,2f)"
        } else if focus * 2.05 / 1.05 <= distance, distance < focus * 1.95 / 0.95 {
            return "~2f"
        } else if focus * 1.95 / 0.95 <= distance {
            return ">2f"
        } else {
            return ""
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            DistanceLabelLineShape(model: model)
                .overlay(
                    HStack(spacing: 5) {
                        HStack(spacing: 1) {
                            Text(String(format: "%.2f", model.distance * 100))
                            Text("cm")
                        }
                        .foregroundColor(.black)
//                        .foregroundColor(.white)
                        .font(Font.body.bold())
                        if model.focus != model.distance {
                            Text(Self.calculateHintLabel(focus: model.focus, distance: model.distance))
                                .font(Font.footnote.bold())
                                .foregroundColor(Color.black.opacity(0.7))
//                                .foregroundColor(Color.white.opacity(0.7))
                        }
                        
                    }
                    .foregroundColor(.black)
//                    .foregroundColor(.white)
                    .font(Font.body.bold())
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .background(
                        RoundedRectangle(cornerRadius: 15.0)
                    )
                    .position(centerPoint)
                    .rotationEffect(
                        Angle(radians: Double(radians)),
                        anchor: .init(x: centerPoint.x / geometry.size.width,
                                      y: centerPoint.y / geometry.size.height)
                    )
                )
                .foregroundColor(.white)
//                .foregroundColor(.black)
        }
    }
}

fileprivate struct DistanceLabelLineShape<Model: HasDistanceLabelViewInfo>: Shape {
    @ObservedObject var model: Model
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.addArc(center: model.startPoint, radius: 10, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
                
            path.addPath(Path { path in
                path.addArc(center: model.endPoint, radius: 10, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
            })
            
            var linePath = Path()
            linePath.move(to: model.startPoint)
            linePath.addLine(to: model.endPoint)
            path.addPath(linePath.strokedPath(StrokeStyle(lineWidth: 5)))
        }
    }
}

//struct DistanceLabelView_Previews: PreviewProvider {
//    static var previews: some View {
//        DistanceLabelView(hadLineModel: )
//    }
//}
