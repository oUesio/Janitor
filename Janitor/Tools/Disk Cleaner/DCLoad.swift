//
//  DCLoad.swift
//  Janitor
//
//  Created by William Luong on 8/7/21.
//

import SwiftUI

struct DCLoad: View {
    @State var load = false
    @State var names = [String: Array<Array<String>>]()
    @State var disk = Array<Disk_Info>()
    @State var update = false
    
    var body: some View {
        if load == false {
            VStack {
                Text("Disk Cleaner")
                    .font(.title)
                    .fontWeight(.bold)
                    .shadow(radius: /*@START_MENU_TOKEN@*/6/*@END_MENU_TOKEN@*/)
                    .padding(.top)
                Spacer()
                Loading(update: update)
                Spacer()
            }
            .frame(width: screen.width / 1.2, height: screen.height - 60)
            .background(Image("Main").resizable())
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    names = [String: Array<Array<String>>](GetFolders())!
                    disk = Disk(folders: names)
                }
            }
        }
        else {
            DC(folders: disk, update: $update)
                .onChange(of: update, perform: { value in
                    load = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {update = false}
                })
        }
    }
    
    func Disk(folders:[String: Array<Array<String>>]) -> Array<Disk_Info> {
        var new = Array<Disk_Info>()
        for amount in 1...folders.count {
            let folder = Array<String>(folders.keys)[amount-1]
            let files = State(files: folders[folder]!)
            new.append(Disk_Info(name: folder, files: files, size: files.map({$0.size}).reduce(0, +)))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {load = true}
        return MergeSortBySize(array: new)
    }
    
    func State(files:Array<Array<String>>) -> Array<Disk_File> {
        var new = Array<Disk_File>()
        for file in files {
            let file_size = GetDirSize(file: file[1])
            new.append(Disk_File(name: file[0], path: file[1], size: Float(file_size)!))
        }
        return MergeSortBySize(array: new)
    }
}


struct DCLoad_Previews: PreviewProvider {
    static var previews: some View {
        DCLoad()
    }
}
