//
//  CutCircle.swift
//  Janitor
//
//  Created by William Luong on 2/26/22.
//

import SwiftUI

struct CutCircle: View {
    var center: CGPoint
    var radius: CGFloat
    var start: Double
    var end: Double
    var colour:  Color
    
    var circle: Path {
        var path = Path()
        path.addArc(center: center, radius: radius, startAngle: Angle(degrees: start), endAngle: Angle(degrees: end), clockwise: false)
        path.addLine(to: center)
        path.closeSubpath()
        return path
    }
    
    var back: Path {
        var path = Path()
        path.addArc(center: center, radius: radius+2, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: false)
        path.addLine(to: center)
        path.closeSubpath()
        return path
    }
    
    var body: some View {
        ZStack {
            back
                .fill(Color.black.opacity(0.1))
            circle
                .fill(colour)
        }
    }
}

struct CutCircle_Previews: PreviewProvider {
    static var previews: some View {
        CutCircle(center: CGPoint(x: 50, y: 50), radius: 50, start: 0, end: 40, colour: Color.red)
    }
}
