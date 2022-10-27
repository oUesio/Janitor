//
//  ARLoad.swift
//  Janitor
//
//  Created by William Luong on 11/13/21.
//

import SwiftUI

struct ARLoad: View {
    @State var load = false
    @State var names = Array<Array<String>>()
    @State var apps = Array<App_Info>()
    @State var update = false
    
    var body: some View {
        if load == false {
            VStack {
                Text("App Remover")
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
                    names = Array<Array<String>>(GetNames())!
                    apps = Apps(apps: names)
                }
            }
        }
        else {
            AR(apps: apps, update: $update).transition(/*@START_MENU_TOKEN@*/.identity/*@END_MENU_TOKEN@*/)
                .onChange(of: update, perform: { value in
                    load = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {update = false}
                })
        }
    }
    
    func Apps(apps:Array<Array<String>>) -> Array<App_Info> {
        var new = Array<App_Info>()
        for amount in 1...apps.count {
            let app = apps[amount-1]
            let files = GetFiles(name_path: app)
            new.append(App_Info(name: app[0], path: app[1], image: String(GetIcon(path: app[1]))!, files: State(files: [String: Array<String>](files)!), size: Float(GetAppsSize(path: app[1], del_files: files))!))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {load = true} 
        return new
    }
    
    func State(files:[String: Array<String>]) -> [String: Array<App_File>] {
        var new = [String: Array<App_File>]()
        for folder in files.keys {
            new[folder] = [App_File]()
            for file in Array<String>(files[folder]!) {
                new[folder]!.append(App_File(path: file))
            }
        }
        return new
    }
}

struct ARLoad_Previews: PreviewProvider {
    static var previews: some View {
        ARLoad()
    }
}
