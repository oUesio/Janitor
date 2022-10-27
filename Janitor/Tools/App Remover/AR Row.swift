//
//  AR Row.swift
//  Janitor
//
//  Created by William Luong on 10/17/21.
//

import SwiftUI

struct App_Info: Hashable {
    let name: String
    let path: String
    let image: String
    var files: [String: Array<App_File>]
    let size: Float
    var state = false
}

struct App_File: Hashable, Files {
    let path: String
    var state = false
}

struct AR_Row: View {
    @Binding var info: App_Info
    @State var expand = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation(.spring()){
                        info.state.toggle()
                    }
                }){
                    Image(nsImage: NSImage(byReferencingFile: info.image)!)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding(.leading, 10)
                    Text(info.name)
                        .font(.system(size:14))
                        .padding(.leading)
                    Spacer()
                }
                .frame(width:275 ,height: 50)
                .background(RoundRectangle(top_right: 6, top_left: 20, bot_right: 6, bot_left: 20).fill(Color.white.opacity(info.state ? 0.2:0)))
                Divider()
                    .padding(.vertical, 8)
                Spacer()
                Text(Convert(size: info.size))
                Button(action: {withAnimation(.spring()){expand.toggle()}}) {
                    Image("Expand1").resizable()
                        .frame(width: 30, height: 30)
                }
                .padding(.trailing)
            }
            .buttonStyle(PlainButtonStyle())
            .background(Color("Grey3"))
            .cornerRadius(20)
            if expand {
                VStack(alignment: .leading) {
                    AR_Main(file: info.path, state: $info.state)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    ForEach(Array(info.files.keys).sorted(by: <), id: \.self) { folder in
                        Divider()
                        AR_Folders(info: $info, folder: folder)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                    }
                }
                .padding()
            }
        }
        .background(Color.gray.opacity(0.15))
        .background(Color("Grey3"))
        .cornerRadius(20)
        .onChange(of: info.state, perform: { state in
            for folder in info.files.keys {
                for (index, _) in info.files[folder]!.enumerated() { info.files[folder]![index].state = state
                }
            }
                
        })
    }
}

struct AR_Main: View {
    @State var file: String
    @Binding var state: Bool
    
    var body: some View {
        HStack {
            Button(action: { withAnimation(.spring()){
                state.toggle()
            }
            }) {
                if state {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Color.green)
                } else {
                    Image(systemName: "circle")
                }
            }
            .buttonStyle(PlainButtonStyle())
            Text(file)
        }
    }
}

struct AR_Folders: View {
    @State var selected = false
    @Binding var info: App_Info
    @State var folder: String
    @State private var expand = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { withAnimation(.spring()){
                    selected.toggle()
                    for (index, _) in info.files[folder]!.enumerated() { info.files[folder]![index].state = selected }
                }
                }) {
                    if selected {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color.green)
                    } else {
                        Image(systemName: "circle")
                    }
                }
                .buttonStyle(PlainButtonStyle())
                Text(folder)
                Spacer()
                Text(String(Amount(files: info.files[folder]!))+" / "+String(info.files[folder]!.count))
                    .padding(.trailing)
                Button(action: { withAnimation(.spring()){expand.toggle()}
                }) {
                    Image("Expand1")
                        .resizable()
                        .frame(width: 15, height: 15)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.trailing)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            if expand {
                ForEach(info.files[folder]!.indices, id: \.self) {
                    pos in AR_File(info: $info, folder: folder, pos: pos)
                        .padding(.vertical, 2)
                        .padding(.leading, 10)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .onAppear(perform: { selected = SelectedFiles(files: info.files[folder]!) })
        .onChange(of: info.files[folder]!, perform: { folder in selected = SelectedFiles(files: folder) })
    }
}

struct AR_File: View {
    @Binding var info: App_Info
    @State var folder: String
    @State var pos: Int
    
    var body: some View {
        HStack {
            Button(action: { withAnimation(.spring()){
                info.files[folder]![pos].state.toggle()
            }
            }) {
                if info.files[folder]![pos].state {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Color.green)
                } else {
                    Image(systemName: "circle")
                }
            }
            .buttonStyle(PlainButtonStyle())
            Text(info.files[folder]![pos].path)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
            Button(action: {ShowFol(path: info.files[folder]![pos].path)}) {
                Image(systemName: "magnifyingglass.circle")
                    .resizable()
                    .frame(width: 15, height: 15)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.trailing)
        }
    }
}

struct AR_Row_Previews: PreviewProvider {
    static var previews: some View {
        AR_Row(info: .constant(App_Info(name: "Test", path: "", image: "/Applications/1Password 7.app/Contents/Resources/opvault.icns", files: [String: Array<App_File>](), size: 10.0)))
    }
}
