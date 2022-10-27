//
//  Main Menu.swift
//  Janitor
//
//  Created by William Luong on 8/6/21.
//

import SwiftUI

var size : [Float] = Array(GetSize())!
var total = size[0]
var used = size[1]
var free = size[2]

struct Main_Menu: View {
    @Binding var select: String
    
    var body: some View {
        let perc = Double(used)/Double(total)
        let (col, desc) = GetColDesc(perc: perc)
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack(alignment: .leading) {
                    Text("Storage Health")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .shadow(radius: /*@START_MENU_TOKEN@*/6/*@END_MENU_TOKEN@*/)
                    Text(desc)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .frame(width: 350.0, height: 40)
                        .shadow(radius: /*@START_MENU_TOKEN@*/6/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                Spacer()
            }
            VStack {
                HStack {
                    ProgressView("Total: "+Convert(size: total), value: Double(used), total: Double(total))
                        .frame(width: 400.0)
                        .accentColor(col)
                        .font(.title2)
                }
                HStack {
                    Spacer()
                    Text("Used: "+Convert(size: used))
                        .font(.title2)
                        .padding(.trailing)
                    Spacer()
                    Text("Free: "+Convert(size: free))
                        .font(.title2)
                        .padding(.leading)
                    Spacer()
                }
            }
            .frame(width: 570.0, height: 90)
            .background(Color("Cyan").opacity(0.6))
            .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
            .shadow(radius: /*@START_MENU_TOKEN@*/6/*@END_MENU_TOKEN@*/)
            .padding(.vertical, 25)

            Spacer()
            HStack {
                Spacer()
                Choice(title: "Disk Cleaner", image1: "Disk1", image2: "Disk2", select: $select)
                Spacer()
                Choice(title: "App Remover", image1: "Bin1", image2: "Bin2", select: $select)
                Spacer()
                Choice(title: "Disk Visualiser", image1: "Glass1", image2: "Glass2", select: $select)
                Spacer()
                
            }
            .padding(.bottom)
            .frame(height: 300)
            Spacer()
        }
        .frame(width: screen.width / 1.2, height: screen.height - 60)
        .background(Image("Main").resizable())
    }
    
    func GetColDesc(perc:Double) -> (Color, String) {
        if (perc > 0.75) {
            return (Color("Red"), "  -  Your storage is running low, it is recommended to remove unnecessary files and apps.")
        } else if (perc > 0.5) {
            return (Color.yellow, "  -  Your storage is almost running low, it is recommended to remove unnecessary files.")
        } else {
            return (Color.green, "  -  Your storage is healthy                                                                     ")
        }
    }
}

struct Main_Menu_Previews: PreviewProvider {
    static var previews: some View {
        Main_Menu(select: .constant("Main Menu"))
    }
}
