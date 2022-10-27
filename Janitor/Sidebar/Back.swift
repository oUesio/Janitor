//
//  Back.swift
//  Janitor
//
//  Created by William Luong on 8/17/21.
//

import SwiftUI

struct Back: View {
    @Binding var select: String
    
    var body: some View {
        Button(action: {select = "Main Menu"}) {
            HStack(spacing: 0) {
                Image("Back")
                    .resizable()
                    .frame(width: 35.0, height: 35.0)
                Text("Main Menu")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 5)
                    .frame(height: 45.0)
                    
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct Back_Previews: PreviewProvider {
    static var previews: some View {
        Back(select: .constant("Main Menu"))
    }
}
