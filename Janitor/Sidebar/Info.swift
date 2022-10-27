//
//  Info.swift
//  Janitor
//
//  Created by William Luong on 9/1/21.
//

import SwiftUI
import PerfectSysInfo

struct Info: View {
    @State var memory = ""
    @State var cpu = String(round((Float(SysInfo.CPU["cpu"]!["user"]!+SysInfo.CPU["cpu"]!["system"]!)/Float(SysInfo.CPU["cpu"]!.values.reduce(0, +)))*1000)/10)
    
    @State var change = true
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 1.0) {
                Text("Storage")
                    .fontWeight(.semibold)
                    .padding(.top, 6)
                Divider()
                Text("Used: "+Convert(size: used))
                Text("Total: "+Convert(size: total))
                CutCircle(center: CGPoint(x: 30, y: 30), radius: 30, start: 0, end: Double(360*(Double(used)/Double(total))), colour: Color("Storage"))
                    .frame(width: 60.0, height: 60.0)
                    .shadow(radius: 4)
                    .padding(.vertical, 8)
            }
            .frame(width: 90.0, height: (screen.height / 2 + 170)*0.25)
            .padding(5)
            .background(Color("Cyan").opacity(0.6))
            .cornerRadius(15)
            VStack {
                VStack(alignment: .leading, spacing: 1.0) {
                    Text("CPU")
                        .fontWeight(.semibold)
                        .padding(.top, 6)
                    Divider()
                    ProgressView("Load: \(cpu)%", value: Float(cpu), total: 100)
                        .accentColor(Color("CPU"))
                }
                .padding(5)
                .frame(height: (screen.height / 2 + 170)*0.25/2)
                .background(Color("Cyan").opacity(0.6))
                .cornerRadius(15)
                
                VStack(alignment: .leading, spacing: 1.0) {
                    Text("Memory")
                        .fontWeight(.semibold)
                        .padding(.top, 6)
                    Divider()
                    Text("Free: "+memory)
                    Spacer()
                }
                .padding(5)
                .frame(height: (screen.height / 2 + 170)*0.25/2)
                .background(Color("Cyan").opacity(0.6))
                .cornerRadius(15)
            }
        }
        .frame(height: (screen.height / 2 + 170)*0.25)
        .onAppear(perform: {
            if Int(SysInfo.Memory["free"]!) > 1000 {
                memory = String(round(Float(SysInfo.Memory["free"]!) / 100)/10)+" GB"
            } else {
                memory = String(SysInfo.Memory["free"]!)+" MB"
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {change.toggle()}
        })
        .onChange(of: change, perform: { value in
            if Int(SysInfo.Memory["free"]!) > 1000 {
                memory = String(round(Float(SysInfo.Memory["free"]!) / 100)/10)+" GB"
            } else {
                memory = String(SysInfo.Memory["free"]!)+" MB"
            }
            cpu = String(round((Float(SysInfo.CPU["cpu"]!["user"]!+SysInfo.CPU["cpu"]!["system"]!)/Float(SysInfo.CPU["cpu"]!.values.reduce(0, +)))*1000)/10)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {change.toggle()}
        })
    }
}

struct Info_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar(select: .constant("Disk Cleaner"))
    }
}
