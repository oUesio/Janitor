//
//  DV Folder.swift
//  Janitor
//
//  Created by William Luong on 3/19/22.
//

import SwiftUI

struct Visualise: View {
    @State var current_fol: Folder
    @State var update = false
    @State private var cols = 0
    @State private var col_size: Float = 0
    @State private var split = Array<[Folder]>()
    @State private var whole_width = screen.width / 1.2 - 270
    @State private var whole_height = screen.height - 210

    var body: some View {
        VStack {
            HStack {
                VStack {
                    if current_fol is Subfolder {
                        Prev_Fol(current_fol: $current_fol, update: $update)
                    }
                }
                .frame(width: 100, height: 35)
                Spacer()
                Text(current_fol.name)
                    .fontWeight(.semibold)
                Text(Convert(size: current_fol.size))
                    .fontWeight(.semibold)
                Spacer()
            }
            .frame(width: whole_width)
            .padding()
            
            if !current_fol.subfolders.isEmpty {
                HStack(alignment: .top, spacing: 2.0) {
                    ForEach(split.indices, id: \.self) {
                        pos in
                        VStack(spacing: 2.0) {
                            let width = (Float(whole_width) - Float(2*cols)) / Float(cols)
                            let cut_height = Float(whole_height*0.7)
                            let add = (whole_height*0.3) / CGFloat(split[pos].count)
                            ForEach(split[pos], id: \.id) {
                                fol in
                                let height = (fol.size / col_size) * cut_height
                                let expand = (height+Float(add)) < Float(whole_height) * 0.03
                                DV_Folder(height: height+Float(add), width: width, folder: fol, current_fol: $current_fol, update: $update, expand: expand)
                            }
                        }
                    }
                }
                .frame(width: whole_width, height: whole_height)
                .onAppear{
                    cols = ColCount(folder: current_fol)
                    (split, col_size) = Split(folder: current_fol, cols: cols)
                }
                .onChange(of: update, perform: { _ in
                    cols = ColCount(folder: current_fol)
                    (split, col_size) = Split(folder: current_fol, cols: cols)
            })
            } else {
                VStack {
                    Text("No Files")
                        .font(.title)
                        .fontWeight(.medium)
                }
                .frame(width: whole_width, height: whole_height)
            }
        Spacer()
        }
    }
    
    func ColCount(folder: Folder) -> Int {
        let count = Float(folder.subfolders.count)
        
        for x in 1...7 {
            if count <= pow(Float(x), 3.0) {
                return x
            }
        }
        return 8
    }

    func Split(folder: Folder, cols: Int) -> (Array<[Subfolder]>, Float) {
        var col_size = folder.size / Float(cols)
        var columns = Array<[Subfolder]>(repeating: [Subfolder](), count: cols)
        var sizes = Array<Float>(repeating: 0.0, count: cols)
        let sub = folder.subfolders.sorted {$0.size > $1.size}

        for fol in sub {
            let temp = sizes.map({abs(Float($0) + fol.size)}).enumerated().min( by: {$0.1 < $1.1})!
            columns[temp.offset].append(fol)
            sizes[temp.offset] += Float(fol.size)
            if sizes[temp.offset] > col_size {
                col_size = sizes[temp.offset]
            }
        }
        columns.reverse()
        return (columns, col_size)
    }
}

struct DV_Folder: View {
    @State private var hover = false
    @State var height: Float
    @State var width: Float
    @State var folder: Folder
    @Binding var current_fol: Folder
    @Binding var update: Bool
    @State var expand: Bool

    var body: some View {
        Button (action: {
            current_fol = folder
            update.toggle()
            if folder.subfolders.isEmpty {
                folder.CreateSubfolders()
            }
        } ){
            VStack {
                Spacer()
                HStack {
                    Text(folder.name)
                        .padding(.leading)
                    Text(Convert(size: folder.size))
                    if folder.name != "Unknown" {
                        Button(action: {ShowFol(path: folder.path)}) {
                            Image(systemName: "magnifyingglass.circle")
                                .resizable()
                                .frame(width: 15, height: 15)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    Spacer()
                }
                Spacer()
            }
            .frame(width: CGFloat(width), height: (hover && expand) ? CGFloat(height+20):CGFloat(height))
            .onHover { over in hover = over }
            .background(Color("Purple"))
            .cornerRadius(5)
            .overlay(
                (hover && expand) ?  RoundedRectangle(cornerRadius: 8)
                .stroke(Color("Grey"), lineWidth: 4):RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.clear, lineWidth: 4)
            )
            .scaleEffect((hover && expand) ? 1.25:1)
            .animation(.easeInOut(duration: 0.1))
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(folder.name == "Unknown")
    }
}

struct Prev_Fol: View {
    @Binding var current_fol: Folder
    @Binding var update: Bool
    
    var body: some View {
        Button(action: {
            if current_fol is Subfolder {
                let temp = current_fol as! Subfolder
                current_fol = temp.parent
                update.toggle()
            }
            }) {
            HStack(spacing: 0) {
                Image("Back")
                    .resizable()
                    .frame(width: 25.0, height: 25.0)
                Text("Back")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 5)
                    .frame(height: 35.0)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

/*
struct DV_Folder_Previews: PreviewProvider {
    static var previews: some View {
        DVLoad()
    }
}

 */
