//
//  Confirm.swift
//  Janitor
//
//  Created by William Luong on 11/6/21.
//

import SwiftUI

var update = false

struct Confirm: View {
    @Binding var confirm: Bool
    @State var first = Array<App_Info>()
    @State var second = Array<App_Info>()
    @State var folders = Array<Disk_Info>()
    @State var tool: String
    @Binding var update: Bool

    var body: some View {
        let selected_apps = CountApps(apps: first+second)
        let selected_folders = CountFolders(folders: folders)
        VStack(spacing: 0) {
            VStack {
                Text("Are you sure you want to delete the selected files?")
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                Text("(This process cannot be reverted)")
                    .fontWeight(.semibold)
                    .padding(.top, 2)
                    .foregroundColor(.red)
                VStack {
                    if tool == "AR" {
                        if selected_apps.count != 0 {
                            VStack(spacing: 1) {
                                Text("Apps selected:")
                                    .font(.headline)
                                Divider()
                                ForEach(selected_apps, id: \.self) {
                                    app in
                                    var temp = app.components(separatedBy: "~")
                                    let last = temp.popLast()
                                    Text(temp.joined(separator: " ")+" ") + Text(last!).fontWeight(.bold)
                                }
                            }
                            .padding(.vertical, 5)
                        } else {
                            Text("No apps selected")
                                .font(.headline)
                        }
                    } else if tool == "DC" {
                        if selected_folders.count != 0 {
                            VStack(spacing: 1) {
                                Text("Folders selected:")
                                    .font(.headline)
                                Divider()
                                ForEach(selected_folders, id: \.self) {
                                    folder in
                                    var temp = folder.components(separatedBy: "~")
                                    let last = temp.popLast()
                                    Text(temp.joined(separator: " ")+" ") + Text(last!).fontWeight(.bold)
                                }
                            }
                            .padding(.vertical, 5)
                        } else {
                            Text("No folders selected")
                                .font(.headline)
                        }
                    }
                }
                .frame(maxWidth: 220, minHeight: 10)
                .background(Color("Grey"))
                .cornerRadius(15)
                .padding(10)
            }
            .frame(maxWidth:240, minHeight:100)
            .background(Color("Grey2"))
            ZStack {
                Text("")
                    .frame(width:240, height:40)
                    .background(Color("Grey2"))
                    .shadow(color:Color("Grey"), radius:8)
                HStack(spacing: 0) {
                    Button(action: {confirm = false}) {
                        Text("Cancel")
                            .frame(width:120, height:40)
                            .background(Color.gray)
                    }
                    .buttonStyle(PlainButtonStyle())
                    Button(action: {
                        confirm = false
                        if tool == "AR" {
                            let all_apps = first+second
                            for app in all_apps {
                                if app.state && FileManager.default.fileExists(atPath: app.path) {
                                    try! FileManager.default.removeItem(atPath: app.path)
                                }
                                for pos in app.files.keys {
                                    for file in app.files[pos]! {
                                        if file.state && FileManager.default.fileExists(atPath: file.path){
                                            try! FileManager.default.removeItem(atPath: file.path)
                                        }
                                    }
                                }
                            }
                        } else if tool == "DC" {
                            for folder in folders {
                                for file in folder.files {
                                    if file.state && FileManager.default.fileExists(atPath: file.path) {
                                        try! FileManager.default.removeItem(atPath: file.path)
                                    }
                                }
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {update = true}
                        size = Array(GetSize())!
                        total = size[0]
                        used = size[1]
                        free = size[2]
                    }) {
                        Text("Delete")
                            .frame(width:120, height:40)
                            .background(Color("Cyan2"))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .cornerRadius(15)
    }
    
    func CountApps(apps: Array<App_Info>) -> Array<String> {
        var temp = Array<String>()
        for app in apps {
            if app.state {
                temp.append(app.name)
            } else {
                for pos in app.files.keys {
                    for file in app.files[pos]! {
                        if file.state && !temp.contains("Some~files~in~"+app.name) {
                            temp.append("Some~files~in~"+app.name)
                            break
                        }
                    }
                }
            }
        }
        return temp
    }
     
    func CountFolders(folders: Array<Disk_Info>) -> Array<String> {
        var temp = Array<String>()
        for folder in folders {
            if folder.state {
                temp.append(folder.name)
            } else {
                for file in folder.files {
                    if file.state {
                        temp.append("Some~files~in~"+folder.name)
                        break
                    }
                }
            }
        }
        return temp
    }
}

struct Confirm_Previews: PreviewProvider {
    static var previews: some View {
        Confirm(confirm: .constant(false), first: [App_Info](), second: [App_Info](), tool: "", update: .constant(false))
    }
}
