//
//  DVLoad.swift
//  Janitor
//
//  Created by William Luong on 8/23/21.
//

import SwiftUI

struct DVLoad: View {
    @State var load = false
    @State var main_fol = Folder(path: "", size: 0)
    
    var body: some View {
        if load == false {
            VStack {
                Text("Disk Visualiser")
                    .font(.title)
                    .fontWeight(.bold)
                    .shadow(radius: /*@START_MENU_TOKEN@*/6/*@END_MENU_TOKEN@*/)
                    .padding(.top)
                Spacer()
                Loading(update: false)
                Spacer()
            }
            .frame(width: screen.width / 1.2, height: screen.height - 60)
            .background(Image("Main").resizable())
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    Fol()
                }
            }
        }
        else {
            DV(fol: main_fol)
        }
    }

    func Fol() {
        main_fol.CreateEmptySubfolders()
        main_fol.SetName()
        for fol in main_fol.subfolders {
            fol.CreateEmptySubfolders()
            for sub in fol.subfolders {
                sub.CreateSubfolders()
                sub.size += Float(GetFileSize(file: sub.path))!
            }
            fol.CalcSize()
            fol.size += Float(GetFileSize(file: fol.path))!
        }
        main_fol.CalcSize()
        main_fol.size += Float(GetFileSize(file: main_fol.path))!
        if Int(main_fol.size.rounded()) < Int(used) {
            let unknown = Subfolder(path: "Unknown", size: Float(used) - main_fol.size.rounded(), parent: main_fol)
            unknown.SetName()
            main_fol.subfolders.append(unknown)
        }
        main_fol.size = Float(used)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {load = true}
    }
}

struct DVLoad_Previews: PreviewProvider {
    static var previews: some View {
        DVLoad()
    }
}
