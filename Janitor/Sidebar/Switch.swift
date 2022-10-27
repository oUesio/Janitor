//
//  Switch.swift
//  Janitor
//
//  Created by William Luong on 8/10/21.
//

import SwiftUI

struct Switch: View {
    @State private var hover = false
    @State var title: String
    @State var image1: String
    @State var image2: String
    
    var animation: Namespace.ID
    
    @Binding var select: String
    var body: some View {
        Button(action: {
            withAnimation(.spring()){select = title}
        }) {
            HStack(spacing: -20) {
                Image(select == title ? image2:(hover ? image2:image1))
                    .resizable()
                    .padding()
                    .frame(width: 75.0, height: 75.0)
                Text(title)
                    .font(.title3)
                    .frame(width: 150.0, height: 75.0)
            }
            .frame(width: 210, height: 60.0)
            .background(RoundRectangle(top_right: 20, top_left: 0, bot_right: 20, bot_left: 0)
                            .fill(Color("Cyan").opacity(select == title ? 0.6:0.3))
                            .frame(width: 235), alignment: .trailing
                )
        }
        .padding(select == title ? .leading:[])
        .buttonStyle(PlainButtonStyle())
        .opacity(select == title ? 1:(hover ? 1 : 0.7))
        .onHover { over in hover = over }
    }
}

struct Switch_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar(select: .constant("Disk Visualiser"))
    }
}
