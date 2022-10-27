//
//  RunDCScript.swift
//  Janitor
//
//  Created by William Luong on 1/8/22.
//

import PythonKit
import Foundation

func RunDCScript() -> PythonObject {
    let sys = Python.import("sys")

    let url = Bundle.main.url(forResource: "DCScript", withExtension: "py")!.deletingLastPathComponent()
    let path = url.absoluteString.dropFirst(7)
    sys.path.append(String(path))
    let file = Python.import("DCScript")
    
    return file
}

func GetFolders() -> PythonObject { 
    let result = RunDCScript().get_folders()
    return result
}

func GetDirSize(file: String) -> PythonObject {
    let result = RunDCScript().get_dir_size(file)
    return result
}

func GetFileSize(file: String) -> PythonObject {
    let result = RunDCScript().get_file_size(file)
    return result
}
