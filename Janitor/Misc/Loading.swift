//
//  Loading.swift
//  Janitor
//
//  Created by William Luong on 2/13/22.
//

import SwiftUI

struct Loading: View {
    @State var update: Bool
    
    var body: some View {
        VStack {
            if update {
                Text("Updating Files . . .")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20))
                    .frame(width: 250)
                
            } else {
            Text("Currently Searching for Files . . .")
                .multilineTextAlignment(.center)
                .font(.system(size: 20))
                .frame(width: 250)
            }
 
            ProgressView(value: 0, total: 0)
                .frame(width: screen.width / 3)
                .scaleEffect(x: 1, y: 2, anchor: .center)
                .accentColor(.green)
        }
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading(update: true)
    }
}
