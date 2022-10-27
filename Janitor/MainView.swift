//
//  MainView.swift
//  Janitor
//
//  Created by William Luong on 8/31/21.
//

import SwiftUI

var screen = NSScreen.main!.visibleFrame

struct MainView: View {
    @State var select = "Main Menu"
    
    var body: some View {
    ZStack {
        switch select {
        case "Main Menu": Main_Menu(select: $select)
        case "Disk Cleaner": DCLoad()
        case "App Remover": ARLoad()
        case "Disk Visualiser": DVLoad()
        default:
            VStack {
                Text("")
            }
            .frame(width: screen.width / 1.2, height: screen.height - 60)
            .background(Image("Main").resizable())
        }
        if select != "Main Menu" {
            VStack {
                HStack() {
                    Sidebar(select: $select)
                    Spacer()
                }
                Spacer()
            }
        }
    }
    .frame(width: screen.width / 1.2, height: screen.height - 60)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
