//
//  Array.swift
//  TDD
//
//  Created by Sam Hiatt  on 3/9/22.
//

import Foundation
struct ArrayFunction {
    
    var array: [Int] = [1,2,3,4,5,6,7,8,9,10]
    
    func evenNumbers(array: [Int]) -> [Int] {
        let filteredArray = array.filter{ $0 % 2 == 0 }
        
        return filteredArray
    }
}

