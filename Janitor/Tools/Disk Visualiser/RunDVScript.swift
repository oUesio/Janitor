//
//  RunDVScript.swift
//  Janitor
//
//  Created by William Luong on 3/6/22.
//

import PythonKit
import Foundation

func RunDVScript() -> PythonObject {
    let sys = Python.import("sys")

    let url = Bundle.main.url(forResource: "DVScript", withExtension: "py")!.deletingLastPathComponent()
    let path = url.absoluteString.dropFirst(7)
    sys.path.append(String(path))
    let file = Python.import("DVScript")
    
    return file
}

func GetSubfolders(path: String) -> PythonObject {
    let result = RunDVScript().get_subfolders(path)
    return result
}

func GetLink(path: String) -> PythonObject {
    let result = RunDVScript().get_link(path)
    return result
}
