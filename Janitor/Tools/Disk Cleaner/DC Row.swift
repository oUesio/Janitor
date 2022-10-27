//
//  DC Row.swift
//  Janitor
//
//  Created by William Luong on 1/8/22.
//

import SwiftUI

protocol Files {
    var state: Bool { get }
}

protocol Disk {
    var size: Float { get }
}

struct Disk_Info: Hashable, Disk {
    let name: String
    var files: Array<Disk_File>
    let size: Float
    var state = false
}

struct Disk_File: Hashable, Files, Disk {
    let name: String
    let path: String
    let size: Float
    var state = false
}

struct DC_Folders: View {
    @Binding var info: Disk_Info
    @State private var expand = false
    @Binding var folders: Array<Disk_Info>
    @Binding var fol: Int
    @State var position: Int
    @Binding var sel: Bool
    @State private var empty = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { withAnimation(.spring()){
                    info.state.toggle()
                    for (index, _) in info.files.enumerated() {
                        info.files[index].state = info.state
                    }
                }
                }) {
                    if info.state {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color.green)
                    } else {
                        Image(systemName: "circle")
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(empty)
                Image(info.name)
                    .resizable()
                    .frame(width: 35, height: 35)
                    .padding(.horizontal, 10)
                Text(info.name)
                    .foregroundColor(empty ? Color.gray:Color.white)
                    .frame(width: 80, alignment: .leading)
                Spacer()
                Text(String(Amount(files: info.files))+" / "+String(empty ? 0:info.files.count))
                    .frame(width: 50)
                    .foregroundColor(empty ? Color.gray:Color.white)
                Text(Convert(size: info.size))
                    .padding(.trailing, 8)
                    .frame(width: 75, height: 35)
                    .foregroundColor(empty ? Color.gray:Color.white)

                Button(action: { withAnimation(.spring()){expand.toggle()
                    if expand {
                        sel = true
                        fol = position
                    } else {
                        sel = false
                        fol = 0
                    }
                }
                }) {
                    Image("Expand2")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .rotationEffect(.degrees(expand ? 180:0))
                        .animation(.easeInOut(duration:0.5))
                }
                .disabled(empty)
                .buttonStyle(PlainButtonStyle())
                .padding(.trailing)
            }
            .frame(height: 60)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.leading, 20)
        .padding(.horizontal, 10)
        .onAppear(perform: { info.state = SelectedFiles(files: info.files) })
        .onChange(of: info.files, perform: { folder in info.state = SelectedFiles(files: folder) })
        .onChange(of: fol, perform: { pos in
            if folders[pos] != info {
                expand = false
            }})
        .onAppear(perform: {if info.files.count == 1 && info.files[0].name == "" {
            empty = true
        }})
    }
}

struct DC_File: View {
    @Binding var info: Disk_Info
    @State var pos: Int
    
    var body: some View {
        VStack {
            if pos != 0 {
                Divider()
                    .padding(.trailing, 10)
            }
            HStack {
                Button(action: { withAnimation(.spring()){
                    info.files[pos].state.toggle()
                }
                }) {
                    if info.files[pos].state {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color.green)
                    } else {
                        Image(systemName: "circle")
                    }
                }
                .buttonStyle(PlainButtonStyle())
                Text(info.files[pos].name)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                Text(Convert(size: info.files[pos].size))
                    .padding(.trailing, 5)
                Button(action: {ShowFol(path: info.files[pos].path)}) {
                    Image(systemName: "magnifyingglass.circle")
                        .resizable()
                        .frame(width: 15, height: 15)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.trailing)
            }
            .frame(height: 25)
        }
    }
}

struct DCRow_Previews: PreviewProvider {
    static var previews: some View {
        DCLoad()
    }
}
