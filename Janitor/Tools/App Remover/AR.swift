//
//  AR.swift
//  Janitor
//
//  Created by William Luong on 8/19/21.
//

import SwiftUI
 
struct AR: View {
    @State var confirm = false
    @State var apps: Array<App_Info>
    @State var first = Array<App_Info>()
    @State var second = Array<App_Info>()
    @Binding var update: Bool
    @State private var search = ""

    var body: some View {
        ZStack {
            VStack {
                Text("App Remover")
                    .font(.title)
                    .fontWeight(.bold)
                    .shadow(radius: /*@START_MENU_TOKEN@*/6/*@END_MENU_TOKEN@*/)
                    .padding(.top)
                Spacer()
                HStack {
                    Spacer()
                    TextField("Search apps", text: $search)
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
                    HStack {
                        ScrollView {
                            ForEach(first.indices, id: \.self) {
                                pos in
                                if search.isEmpty {
                                    AR_Row(info: $first[pos])
                                        .padding(.horizontal, 7)
                                        .shadow(color: Color("Grey3"), radius: 5)
                                } else if first[pos].name.uppercased().contains(search.uppercased()) {
                                    AR_Row(info: $first[pos])
                                        .padding(.horizontal, 7)
                                        .shadow(color: Color("Grey3"), radius: 5)
                                 }
                            }
                            .padding(.vertical, 10)
                        }
                        .padding(.trailing)
                             
                        ScrollView {
                            ForEach(second.indices, id: \.self) {
                                pos in
                                if search.isEmpty {
                                    AR_Row(info: $second[pos])
                                        .padding(.horizontal, 7)
                                        .shadow(color: Color("Grey3"), radius: 5)
                                } else if second[pos].name.uppercased().contains(search.uppercased()) {
                                    AR_Row(info: $second[pos])
                                         .padding(.horizontal ,7)
                                         .shadow(color: Color("Grey3"), radius: 5)
                                 }
                            }
                            .padding(.vertical, 10)
                        }
                    }
                    .frame(width: screen.width / 1.2 - 280, height: screen.height - 170)
                }
                Spacer()
            }
            .frame(width: screen.width / 1.2, height: screen.height - 60)
            .background(Image("Main").resizable())
            VStack {
                Spacer()
                if confirm {
                    Confirm(confirm: $confirm, first: first, second: second, tool: "AR", update: $update)
                }
                Spacer()
            }
            .frame(width: screen.width / 1.2, height: screen.height - 60)
            .background(Color.black.opacity(confirm ? 0.4:0))
        }
        .onAppear {(first, second) = Split(apps:apps)}
    }

    func Split(apps:Array<App_Info>) -> (Array<App_Info>, Array<App_Info>) {
        let half = apps.count / 2
        return(Array<App_Info>(apps[0..<half]), Array<App_Info>(apps[half..<apps.count]))
    }
}

struct AR_Previews: PreviewProvider {
    static var previews: some View {
        ARLoad()
    }
}
