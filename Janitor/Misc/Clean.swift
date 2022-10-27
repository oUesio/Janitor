//
//  Clean.swift
//  Janitor
//
//  Created by William Luong on 8/25/21.
//

import SwiftUI

struct Clean: View {
    @State private var hover = false
    @Binding var confirm: Bool
    
    var body: some View {
        Button(action: {confirm = true}) {
            VStack {
                Text("Clean")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .frame(width: 100.0, height: 100)
            .cornerRadius(7)
            .background(Color("Grey2"))
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(LinearGradient(gradient: Gradient(colors: [Color("Grey")]), startPoint: .leading, endPoint: .trailing), lineWidth: 5)
                    .frame(width:85)
                    .shadow(radius: 2)
            )
            .overlay(
                Circle()
                    .trim(from:0, to:hover ? 1:0)
                    .stroke(LinearGradient(gradient: Gradient(colors: [Color("Purple"), Color("Purple"), Color("Purple-Cyan"), Color("Cyan")]), startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                    .frame(width:85)
                    .rotationEffect(.degrees(hover ? 360:0))
                    .animation(.easeInOut(duration:1))
            )
        }
        .buttonStyle(PlainButtonStyle())
        .shadow(radius: 8)
        .onHover { over in hover = over }
    }
}

struct Clean_Previews: PreviewProvider {
    static var previews: some View {
        Clean(confirm: .constant(false))
    }
}
