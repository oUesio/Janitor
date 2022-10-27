//
//  DV.swift
//  Janitor
//
//  Created by William Luong on 8/19/21.
//

import SwiftUI

struct DV: View {
    @State var fol: Folder
    
    var body: some View {
        VStack {
            Text("Disk Visualiser")
                .font(.title)
                .fontWeight(.bold)
                .shadow(radius: /*@START_MENU_TOKEN@*/6/*@END_MENU_TOKEN@*/)
                .padding(.top)
            Spacer()
            HStack {
                Spacer()
                Visualise(current_fol: fol)
                    .padding(.leading)
            }
            Spacer()
        }
        .frame(width: screen.width / 1.2, height: screen.height - 60)
        .background(Image("Main").resizable())
    }
}

struct DV_Previews: PreviewProvider {
    static var previews: some View {
        DVLoad()
    }
}
