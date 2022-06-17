import UIKit

//var inputArray = [2, 4, -1, 3, 0, 6]
//var sum = 5
//
//func findTwoSumHash(inputArray: [Int], sum: Int) {
//    var dictionary: [Int: Int] = [:]
//
//    for element in inputArray {
//        let difference = sum - element
//
//        if let _ = dictionary[difference] {
//            print("(\(element), \(difference)")
//        }
//
//        dictionary[element] = element
//    }
//}
//findTwoSumHash(inputArray: inputArray, sum: sum)

var somearray = [1,2,3,4,5,6,7,8]
var sums = 5
func checkForMatch(numbers: [Int], target: Int) -> [Int]? {
    for (i, x) in numbers.enumerated() {
        for y in numbers[i+1 ..< numbers.count] {
            if x + y == target {
                return [x,y]
            }
            if x + y > target {
                break
            }
        }
    }
    return nil
}
checkForMatch(numbers: somearray, target: sums)


class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        for (i, x) in nums.enumerated() {
            for y in nums[i+1 ..< nums.count] {
                if x + y == target {
                    return [x,y]
                }
                if x + y > target {
                    break
                }
            }
        }
    }
}
