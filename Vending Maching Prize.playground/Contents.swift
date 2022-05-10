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

func segragate(nums: [Int]) -> [[Int]] {
    var evenArray: [Int] = []
    var oddsArray: [Int] = []
    
    for num in nums {
        if num % 2 == 0 {
            evenArray.append(num)
        } else {
            oddsArray.append(num)
        }
    }
    
    return [evenArray,oddsArray]
}

var numbers = [1,2,3,4,5,6,7,8,9,10]
print(segragate(nums: numbers))
