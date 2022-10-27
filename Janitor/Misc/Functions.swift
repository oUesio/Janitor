//
//  Round.swift
//  Janitor
//
//  Created by William Luong on 3/24/22.
//

import SwiftUI

func Rounded(_ num: Double, to places: Int) -> Double {
    let a = log10(abs(num))
    let b = pow(10, a.rounded() - Double(places) + 1)
    let num = (num / b).rounded() * b
    if num.isNaN {
        return 0.0
    }

    return round(num * 100) / 100
}

func Remove(val: Double) -> String {
    return val.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", val) : String(val)
}

func Convert(size: Float) -> String {
    if size > pow(10.0, 9.0) {
        return Remove(val: Rounded(Double(size) / pow(10.0, 9.0), to: 3)) + " GB"
    } else if size > pow(10.0, 6.0) {
        return Remove(val: Rounded(Double(size) / pow(10.0, 6.0), to: 3)) + " MB"
    } else {
        return Remove(val: Rounded(Double(size) / pow(10.0, 3.0), to: 3)) + " KB"
    }
}

func ShowFol(path: String) {
    let urlPath = URL(fileURLWithPath: path)
    let selectedURLs = [urlPath]
    return NSWorkspace.shared.activateFileViewerSelecting(selectedURLs)
}

func Merge<d: Disk>(left: [d], right: [d]) -> [d] {
    var arr = [d]()
    var left = left
    var right = right
    
    while left.count > 0 && right.count > 0 {
        if left.first!.size > right.first!.size {
            arr.append(left.removeFirst())
        } else {
            arr.append(right.removeFirst())
        }
    }
    return arr + left + right
}

func MergeSortBySize<d: Disk>(array: [d]) -> [d] {
    guard array.count > 1 else {
        return array
    }
    let half = array.count / 2
    
    return Merge(left: MergeSortBySize(array: Array(array[0..<half])), right: MergeSortBySize(array: Array(array[half..<array.count])))
}

func SelectedFiles<f: Files>(files: [f]) -> Bool {
    for file in files {
        if file.state == false {
            return false
        }
    }
    return true
}
    
func Amount<f: Files>(files: [f]) -> Int {
    var count = 0
     for file in files {
        if file.state == true {
            count += 1
        }
    }
    return count
}

