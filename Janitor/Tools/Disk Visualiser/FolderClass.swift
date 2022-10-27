//
//  Folder Class.swift
//  Janitor
//
//  Created by William Luong on 3/6/22.
//

import SwiftUI

class Folder {
    let id: UUID
    var name = ""
    var size: Float
    var path: String
    var subfolders = Array<Subfolder>()

    init(path: String, size: Float) {
        self.id = UUID()
        self.path = path
        self.size = size
    }

    func CalcSize() {
        self.size += self.subfolders.map({$0.size}).reduce(0, +)
    }
    
    func SetName() {
        self.name = String(FileManager().displayName(atPath: "/"))
    }
   
    func CreateSubfolders() {
        let subfols = Array<String>(GetSubfolders(path: self.path))!
        if subfols.isEmpty == false {
            for fol in subfols {
                if !Bool(GetLink(path: fol))! && !fol.contains("/Volumes") && !fol.contains("/System/Volumes/Data") {
                    let sub = Subfolder(path: fol, size: Float(GetDirSize(file: fol))!, parent: self)
                    sub.SetName()
                    self.subfolders.append(sub)
                }
            }
            if self.size == 0 {
                self.CalcSize()
            }
        }
    }
    
    func CreateEmptySubfolders() {
        let subfols = Array<String>(GetSubfolders(path: self.path))!
        if subfols.isEmpty == false {
            for fol in subfols {
                if !Bool(GetLink(path: fol))! && fol != "/Volumes" && fol != "/System/Volumes/Data" {
                    let sub = Subfolder(path: fol, size: 0, parent: self)
                    sub.SetName()
                    self.subfolders.append(sub)
                }
            }
        }
    }
}


class Subfolder: Folder {
    var parent: Folder

    init(path: String, size: Float, parent: Folder) {
        self.parent = parent
        super.init(path: path, size: size)
    }
    
    override func SetName() {
        if self.path == "Unknown" {
            self.name = "Unknown"
        } else {
            self.name = self.path.components(separatedBy: "/").last!
        }
    }
}
