//
//  RoundedCorners.swift
//  Janitor
//
//  Created by William Luong on 8/28/21.
//

import SwiftUI

struct RoundRectangle: Shape {
    var top_right: CGFloat
    var top_left: CGFloat
    var bot_right: CGFloat
    var bot_left: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height

        path.move(to: CGPoint(x: width / 2.0, y: 0))
        path.addLine(to: CGPoint(x: width - top_right, y: 0))
        path.addArc(center: CGPoint(x: width - top_right, y: top_right), radius: top_right, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
        path.addLine(to: CGPoint(x: width, y: height - bot_right))
        path.addArc(center: CGPoint(x: width - bot_right, y: height - bot_right), radius: bot_right, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        path.addLine(to: CGPoint(x: bot_left, y: height))
        path.addArc(center: CGPoint(x: bot_left, y: height - bot_left), radius: bot_left, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        path.addLine(to: CGPoint(x: 0, y: top_left))
        path.addArc(center: CGPoint(x: top_left, y: top_left), radius: top_left, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        path.closeSubpath()
        
        return path
    }
}
