//: Playground - noun: a place where people can play

import UIKit
import Foundation


// 42.

/**
 
 Do as directed in question. For each element in the array, we find the maximum level of water it can trap after the rain, which is equal to the minimum of maximum height of bars on both the sides minus its own height.
 
 每一条的容积就是两测的高度减去自己的高度，加起来，最笨的方法
 
 int trap(vector<int>& height)
 {
 int ans = 0;
 int size = height.size();
 for (int i = 1; i < size - 1; i++) {
 int max_left = 0, max_right = 0;
 for (int j = i; j >= 0; j--) { //Search the left part for max bar size
 max_left = max(max_left, height[j]);
 }
 for (int j = i; j < size; j++) { //Search the right part for max bar size
 max_right = max(max_right, height[j]);
 }
 ans += min(max_left, max_right) - height[i];
 }
 return ans;
 }
 
 
 
 Search from left to right and maintain a max height of left and right separately, which is like a one-side wall of partial container. Fix the higher one and flow water from the lower part. For example, if current height of left is lower, we fill water in the left bin. Until left meets right, we filled the whole container
 
 https://leetcode.com/articles/trapping-rain-water/
 
 
 
 */


/*
 var array = [0,1,0,2,1,0,1,3,2,1,2,1]
 
 func trapingRain(_ array: [Int]) -> Int {
 
 var indexL: Int = 0
 var indexR: Int = array.count - 1
 
 var maxL: Int = 0
 var maxR: Int = 0
 
 var result = 0
 
 while indexL <= indexR {
 
 let valueL = array[indexL]
 let valueR = array[indexR]
 
 if valueL <= valueR {
 
 if valueL >= maxL {
 maxL = valueL
 } else {
 result += maxL - valueL
 }
 indexL += 1
 } else {
 
 if valueR > maxR {
 maxR = valueR
 } else {
 result += maxR - valueR
 }
 indexR -= 1
 }
 }
 
 return result
 }
 
 
 // 48. Rotate Image
 
 /**
 
 You are given an n x n 2D matrix representing an image.
 
 Rotate the image by 90 degrees (clockwise).
 
 Follow up:
 Could you do this in-place?
 
 */
 /*
 * clockwise rotate
 * first reverse up to down, then swap the symmetry
 * 1 2 3     7 8 9     7 4 1
 * 4 5 6  => 4 5 6  => 8 5 2
 * 7 8 9     1 2 3     9 6 3
 */
 
 
 var arraytoRotate: [[Int]] = [
 [1, 2, 3],
 [4, 5, 6],
 [7, 8, 9]
 ]
 
 func rotateArrayClockwise(_ parray: [[Int]]) -> [[Int]] {
 
 var tempArray = parray.reversed() as [[Int]]
 let size = tempArray.count
 
 for i in 0..<size {
 
 for j in (i + 1)..<size {
 let temp = tempArray[i][j]
 tempArray[i][j] = tempArray[j][i]
 tempArray[j][i] = temp
 }
 }
 return tempArray
 }
 
 rotateArrayClockwise(arraytoRotate)
 print(arraytoRotate)
 
 
 func reverseUpDown(_array: [[Int]]) -> [[Int]] {
 
 return arraytoRotate
 }
 
 /*
 * anticlockwise rotate
 * first reverse left to right, then swap the symmetry
 * 1 2 3     3 2 1     3 6 9
 * 4 5 6  => 6 5 4  => 2 5 8
 * 7 8 9     9 8 7     1 4 7
 */
 
 
 
 */

//49. Group Anagrams

let anagramArray = ["eat", "tea", "tan", "ate", "nat", "bat"]

func groupAnagrams(_ strs: [String]) -> [[String]] {
    
    var result:[[String]]
    var tempDic = [String: [String]]()
    
    for string in strs {
        
        let sequencedString = String(string.characters.sorted())
        if tempDic[sequencedString] != nil {
            tempDic[sequencedString]?.append(string)
        } else {
            tempDic[sequencedString] = [string]
        }
    }
    result = Array(tempDic.values)
    return result
}

let array = groupAnagrams(anagramArray)
print(array)





// 43
//https://discuss.leetcode.com/topic/30508/easiest-java-solution-with-graph-explanation

func multiply(_ num1: String, _ num2: String) -> String {
    return ""
}


// 26. remove duplicated from sorted array

/**
 
 Given a sorted array, remove the duplicates in place such that each element appear only once and return the new length.
 
 Do not allocate extra space for another array, you must do this in place with constant memory.
 
 For example,
 Given input array nums = [1,1,2],
 
 Your function should return length = 2, with the first two elements of nums being 1 and 2 respectively. It doesn't matter what you leave beyond the new length.
 
 */

var duplicatedArray = [1, 2, 2, 3]

func removeDuplicates(_ nums: inout [Int]) -> Int {
    
    if nums.count == 0 {
        return 0
    }
    
    var index = 0
    for num in nums {
        
        //这里用了短路
        //两个游标，第二个是为了让不重复的数字前移，遇到重复的停下来，直到出现不重复的，才把不重复的copy到下边那个
        if index == 0 || num > nums[index - 1]  {
            nums[index] = num
            index += 1
        }
    }
    return index
}



//38. Count and Say

func countAndSay(_ n: Int) -> String {
    
    
    var primary = "1"
    if n == 1 {
        return primary
    }
    
    for _ in 2...n {
        primary = countAndSayFromLast(primary)
    }
    return primary
}

func countAndSayFromLast(_ string: String) -> String {

    var result = ""
    var temp = string
    
    if temp.characters.count == 1 {
        let character =  temp.characters.first!
        result.append("1")
        result.append(character)
        return result
    }
    
    while temp.characters.count > 0 {
        
        let sIndex = temp.startIndex

        let character =  temp.characters.first!
        
        var count = 1
        for index in 1..<temp.characters.count {
            
            let numIndex = temp.characters.index(sIndex, offsetBy: index)
            if  temp.characters[numIndex] == character {
                count += 1
            } else {
                break
            }
        }
        let eIndex = temp.characters.index(sIndex, offsetBy: count)
        result.append("\(count)")
        result.append(character)
        temp.characters.removeSubrange(sIndex..<eIndex)
    }
    
    return result
    
}





























