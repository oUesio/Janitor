//
//  DC.swift
//  Janitor
//
//  Created by William Luong on 8/23/21.
//

import SwiftUI

struct DC: View {
    @State var confirm = false
    @State var folders: Array<Disk_Info>
    @State var fol = 0
    @State var sel = false
    @Binding var update: Bool
    @State private var search = ""

    var results: Array<Disk_File> {
        if search.isEmpty {
            return folders[fol].files
        } else {
            var temp = folders[fol].files
            for pos in folders[fol].files.indices {
                if !folders[fol].files[pos].name.uppercased().contains(search.uppercased()) {
                    temp[pos] = Disk_File(name: "", path: "", size: 0.0)
                }
            }
            return temp
        }
    }

    var body: some View {
        ZStack {
            VStack {
                Text("Disk Cleaner")
                    .font(.title)
                    .fontWeight(.bold)
                    .shadow(radius: /*@START_MENU_TOKEN@*/6/*@END_MENU_TOKEN@*/)
                    .padding(.top)
                Spacer()
                HStack {
                    Spacer()
                    TextField("Search files", text: $search)
                        .frame(width: (screen.width / 1.2 - 280) * (4/16))
                        .padding(.horizontal)
                }
                HStack {
                    VStack {
                        Spacer()
                        Clean(confirm: $confirm)
                            .padding()
                    }
                    .frame(width: 240)
                    Spacer()
                    HStack(spacing: 0.0) {
                        ScrollView {
                            VStack(spacing: 0.0) {
                                ForEach(folders.indices, id: \.self) {
                                    pos in
                                    if pos % 2 == 0 {
                                        DC_Folders(info: $folders[pos], folders: $folders, fol: $fol, position: pos, sel: $sel)
                                    } else {
                                        DC_Folders(info: $folders[pos], folders: $folders, fol: $fol, position: pos, sel: $sel)
                                            .background(Color.white.opacity(0.1))
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 10)
                        .background(RoundRectangle(top_right: 0, top_left: 50, bot_right: 0, bot_left: 50).fill(Color("Grey3"))
                                .shadow(color: Color("Grey3"), radius: 6))
                        .frame(width: (screen.width / 1.2 - 280) * (7/16), height: screen.height - 170)
                        .shadow(color: Color("Grey3"), radius: 6)
                        VStack {
                            if sel {
                                ScrollView {
                                    VStack(spacing: 1) {
                                        ForEach(results.indices, id: \.self) {
                                            pos in
                                            if results[pos].name != "" {
                                                DC_File(info: $folders[fol], pos: pos)
                                                    .padding(.vertical, 2)
                                                    .padding(.leading, 10)
                                            }
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .padding(.vertical, 12)
                                }
                            } else {
                                VStack {
                                    Spacer()
                                    Text("No folder selected")
                                        .font(.title)
                                        .fontWeight(.medium)
                                    Spacer()
                                }
                            }
                        }
                        .frame(width: (screen.width / 1.2 - 280) * (9/16), height: screen.height - 170)
                        .background(Color.white.opacity(0.1))
                        .background(Color("Grey3"))
                        .shadow(color: Color("Grey3"), radius: 6)
                    }
                    .frame(width: screen.width / 1.2 - 280, height: screen.height - 170)
                    .clipShape(RoundRectangle(top_right: 0, top_left: 50, bot_right: 0, bot_left: 50))
                    .shadow(color: Color("Grey3"), radius: 6)
                    .shadow(color: Color("Grey3"), radius: 8)
                }
                Spacer()
            }
            .frame(width: screen.width / 1.2, height: screen.height - 60)
            .background(Image("Main").resizable())
            VStack {
                Spacer()
                if confirm {
                    Confirm(confirm: $confirm, folders: folders, tool: "DC", update: $update)
                }
                Spacer()
            }
            .frame(width: screen.width / 1.2, height: screen.height - 60)
            .background(Color.black.opacity(confirm ? 0.4:0))
        }
    }
}


struct DC_Previews: PreviewProvider {
    static var previews: some View {
        DCLoad()
    }
}
