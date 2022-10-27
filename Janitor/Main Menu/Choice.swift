//
//  Choice.swift
//  Janitor
//
//  Created by William Luong on 8/6/21.
//

import SwiftUI

struct Choice: View {
    @State private var hover1 = false
    @State private var hover2 = false
    
    @State var title: String
    @State var image1: String
    @State var image2: String
    
    @Binding var select: String
    @State var info = ""
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "info.circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .opacity(hover1 ? 0.6:1)
                    .animation(.easeInOut(duration:0.2))
                    .overlay(Text(info)
                        .padding(10)
                        .background(hover1 ? RoundedRectangle(cornerRadius: 10).foregroundColor(Color.gray).opacity(/*@START_MENU_TOKEN@*/0.2/*@END_MENU_TOKEN@*/):RoundedRectangle(cornerRadius: 10).foregroundColor(Color.clear).opacity(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/))
                        .frame(width: 350.0, height: 130)
                        .shadow(radius: /*@START_MENU_TOKEN@*/6/*@END_MENU_TOKEN@*/)
                        .font(.body)
                        .offset(x: -100,y: -50)
                    )
                    .onHover { over in hover1.toggle()
                            info = GetInfo(title: title)
                    }
            }
            .frame(width: 250, height: 40)
            Button (action: {
                select = title
            }) {
                VStack {
                    Spacer()
                    Text(title)
                    .font(.title)
                    Spacer()
                    Image(hover2 ? image2:image1)
                    .resizable()
                    .frame(width: 70.0, height: 70.0)
                    Spacer()
                }
                .frame(width: 180, height: 180)
                .background(Color("Cyan")
                .opacity(hover2 ? 0.7 : 0.4))
                .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                .shadow(radius: 8)
                .onHover { over in hover2 = over }
                .scaleEffect(hover2 ? 1.125:1)
                .animation(.easeInOut(duration: 0.2))
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    func GetInfo(title:String) -> String {
        if hover1 == false {
            return ""
        }
        if title == "Disk Cleaner" {
            return "Disk Cleaner finds unnecessary files which can be deleted to free up storage space"
        } else if title == "App Remover" {
            return "App Remover uninstalls apps fully by also removing any files associated"
        } else if title == "Disk Visualiser" {
            return "Disk Visualiser displays each folder's subfolders and files proportional to its total size"
        } else {
            return ""
        }
    }
}

struct Choice_Previews: PreviewProvider {
    static var previews: some View {
        Choice(title: "Test", image1: "Disk1", image2: "Disk2", select: .constant(""))
    }
}

