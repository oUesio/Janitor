//
//  RunInfo.swift
//  Janitor
//
//  Created by William Luong on 10/17/21.
//

import PythonKit
import Foundation

func RunARScript() -> PythonObject {
    let sys = Python.import("sys")

    let url = Bundle.main.url(forResource: "ARScript", withExtension: "py")!.deletingLastPathComponent()
    let path = url.absoluteString.dropFirst(7)
    sys.path.append(String(path))
    let file = Python.import("ARScript")
    
    return file
}

func GetNames() -> PythonObject {
    let result = RunARScript().get_names_paths()
    return result
}

func GetIcon(path: String) -> PythonObject {
    let result = RunARScript().get_icon(path)
    return result
}

func GetFiles(name_path: Array<String>) -> PythonObject {
    let result = RunARScript().get_files(name_path)
    return result
}

func GetAppsSize(path: String, del_files: PythonObject) -> PythonObject {
    let result = RunARScript().get_app_size(path, del_files)
    return result
}

