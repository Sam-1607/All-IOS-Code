import Foundation
import UIKit
import PlaygroundSupport



func center (strng: String, width: Int, fill: String = " ") -> String {
    let padAmount = width - strng.count
    var pad1 = padAmount / 2
    var pad2 = padAmount / 2
    
    if padAmount % 2 != 0 {
        pad1 = padAmount / 2 + 1
        pad2 = padAmount / 2
      }
    
    let startPadding = String(repeating: fill, count: pad1)
    let endPadding = String(repeating: fill, count: pad2)
    let combinedString = "\(startPadding)\(strng)\(endPadding)"
    
    if strng.count > width {
        return strng
    }
    return combinedString
}


PlaygroundPage.current.needsIndefiniteExecution = true

