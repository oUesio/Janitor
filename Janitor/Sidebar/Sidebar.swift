//
//  Switch.swift
//  Janitor
//
//  Created by William Luong on 8/8/21.
//

import SwiftUI

struct Sidebar: View {
    @Binding var select: String
    
    @Namespace var animation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Back(select: $select)
                .padding([.top, .horizontal])
            Info()
            .padding(.horizontal, 10)
            HStack {
                if select == "Disk Cleaner" {
                    Text("Disk Cleaner finds unnecessary files which can be deleted to free up storage space")
                        .fontWeight(.semibold)
                        .padding(7)
                } else if select == "App Remover" {
                    Text("App Remover uninstalls apps fully by also removing any files associated")
                        .fontWeight(.semibold)
                        .padding(7)
                } else if select == "Disk Visualiser" {
                    Text("Disk Visualiser displays each folder's subfolders and files proportional to its total size")
                        .fontWeight(.semibold)
                        .padding(7)
                }
            }
            .frame(height: (screen.height / 2 + 170)*0.175)
            .background(Color("Cyan").opacity(0.6))
            .cornerRadius(15)
            .padding(.horizontal, 10)
            Switch(title: "Disk Cleaner", image1: "Disk1", image2: "Disk2", animation: animation, select: $select)
            Switch(title: "App Remover", image1: "Bin1", image2: "Bin2", animation: animation, select: $select)
            Switch(title: "Disk Visualiser", image1: "Glass1", image2: "Glass2", animation: animation, select: $select)
                .padding(.bottom, 30)
        }
        .frame(width: 240, height: screen.height / 2 + 170)
        .background(RoundRectangle(top_right: 0, top_left: 0, bot_right: 50, bot_left: 0)
                .fill(Color("Grey"))
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                .shadow(color: Color("Grey3"), radius: 8)
                .shadow(color: Color("Grey3"), radius: 10)
                .frame(width: 240, height: screen.height / 2 + 170), alignment: .top)
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar(select: .constant("Disk Cleaner"))
    }
}
