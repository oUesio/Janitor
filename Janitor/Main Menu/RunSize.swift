//
//  RunScript.swift
//  Janitor
//
//  Created by William Luong on 8/11/21.
//

import PythonKit
import Foundation

func GetSize() -> PythonObject {
    let sys = Python.import("sys")

    let url = Bundle.main.url(forResource: "Size", withExtension: "py")!.deletingLastPathComponent()
    let path = url.absoluteString.dropFirst(7)
    sys.path.append(String(path))
    let file = Python.import("Size")
    //let file = try? Python.attemptImport("Size")
    //if file == nil {
    //    return [0,0,0]
    //}

    let result = file.get_disk_size()
    return result
}

