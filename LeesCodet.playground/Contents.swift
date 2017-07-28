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

//let array = groupAnagrams(anagramArray)
//print(array)





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


//19. remove the Nth node from the end of the list 

/**
 
 Given a linked list, remove the nth node from the end of list and return its head.
 
 For example,
 
 Given linked list: 1->2->3->4->5, and n = 2.
 
 After removing the second node from the end, the linked list becomes 1->2->3->5.
 Note:
 Given n will always be valid.
 Try to do this in one pass.
 
 
 */
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    
    if head == nil {
        return head
    }
    
    let start = ListNode(0)
    start.next = head
    var slow: ListNode? = start
    var fast: ListNode? = start
    
    for _ in 0..<n {
        fast = fast?.next
    }
    
    while fast?.next != nil {
        fast = fast?.next
        slow = slow?.next
    }
    
    slow?.next = slow?.next?.next
    
    return start.next
}


//27. remove element
/**
 
 Given an array and a value, remove all instances of that value in place and return the new length.
 
 Do not allocate extra space for another array, you must do this in place with constant memory.
 
 The order of elements can be changed. It doesn't matter what you leave beyond the new length.
 
 Example:
 Given input array nums = [3,2,2,3], val = 3
 
 Your function should return length = 2, with the first two elements of nums being 2.
 
 */
func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
    
    var num = 0;
    for index in 0..<nums.count {
        if val != nums[index] {
            nums[num] = nums[index]
            num += 1
        }
    }
    return num
}


func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    
    var left = 0
    var right = nums.count - 1
    
    while left <= right {
        
        let mid: Int =  left + (right - left) / 2
        
        if nums[mid] <= target {
            left = mid + 1
        } else {
            right = mid - 1
        }
        
    }
    return left
}


//26. valid parentheses

/**
 
 Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
 
 The brackets must close in the correct order, "()" and "()[]{}" are all valid but "(]" and "([)]" are not.
 
 */

func isValid(_ string: String) -> Bool {
    var stack = [Character]()
    
    for char in string.characters {
        
        if char == "("  {
            stack.append(")")
        } else if char == "[" {
            stack.append("]")
        } else if char == "{" {
            stack.append("}")
        } else if (stack.count == 0 || stack.removeLast() != char) {
            return false
        }
    }
    return stack.count == 0
}


// 202. Happy Number
/*
 
 Write an algorithm to determine if a number is "happy".
 
 A happy number is a number defined by the following process: Starting with any positive integer, replace the number by the sum of the squares of its digits, and repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1. Those numbers for which this process ends in 1 are happy numbers.
 
 Example: 19 is a happy number
 
 12 + 92 = 82
 82 + 22 = 68
 62 + 82 = 100
 12 + 02 + 02 = 1
 */
func digitSum(_ n: Int) -> Int {
    
    var temp = n
    var sum: Int = 0
    while temp > 0 {
        
        let remain = temp % 10
        sum += remain * remain
        temp = temp / 10
    }
    
    return sum
}

func isHappy(_ n: Int) -> Bool {
    
    /*var slow = n
    var fast = n
    repeat {
        slow = digitSum(slow)
        fast = digitSum(fast)
        fast = digitSum(fast)
    } while slow != fast
    
    return slow == 1*/
    
    
    //有人提出质疑，快指针不一定能刚好抓住慢的，
    var set = Set<Int>()
    
    var temp = digitSum(n)
    
    while !set.contains(temp) {
        
        set.insert(temp)
        if temp == 1 {
            return true
        }
        temp = digitSum(temp)
    }
    
    return false
}


//203. Remove Linked List Elements
/**
 
 Remove all elements from a linked list of integers that have value val.
 
 Example
 Given: 1 --> 2 --> 6 --> 3 --> 4 --> 5 --> 6, val = 6
 Return: 1 --> 2 --> 3 --> 4 --> 5
 
 */

func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
    
    if head == nil {
        return head
    }
    
    let temp = ListNode(0)
    temp.next = head
    var slow: ListNode? = temp
    var fast = slow?.next
    
    while fast != nil {
        if fast?.val == val {
            slow?.next = fast?.next
            fast = fast?.next
        } else {
            slow = slow?.next
            fast = fast?.next
        }
    }
    
    return temp.next
}


//204. cout the primes
/**
 
 西元前250年，希腊数学家厄拉多塞(Eeatosthese)想到了一个非常美妙的质数筛法，减少了逐一检查每个数的的步骤，可以比较简单的从一大堆数字之中，筛选出质数来，这方法被称作厄拉多塞筛法(Sieve of Eeatosthese)。
 
 具体操作：先将 2~n 的各个数放入表中，然后在2的上面画一个圆圈，然后划去2的其他倍数；第一个既未画圈又没有被划去的数是3，将它画圈，再划去3的其他倍数；现在既未画圈又没有被划去的第一个数 是5，将它画圈，并划去5的其他倍数……依次类推，一直到所有小于或等于 n 的各数都画了圈或划去为止。这时，表中画了圈的以及未划去的那些数正好就是小于 n 的素数。
 */

func countPrimes(_ n: Int) -> Int {
    
    if n < 2 {
        return 0
    }
    
    var count = 0
    var flags = Array<Bool>(repeatElement(false, count: n))
    for num in 2...n {
        
        if flags[num] == false {
            count += 1
            var j = 2
            while num * j < n {
                flags[num * j] = true
                j += 1
            }
        }
    }
    return count
}

let a = countPrimes(2)




//205. Isomorphic Strings
func isIsomorphic(_ s: String, _ t: String) -> Bool {
    
    var mapS = [Character: Character]()
    var mapT = [Character: Character]()
    
    for index in 0..<s.characters.count {
        let charInS = s[s.index(s.startIndex, offsetBy: index)]
        let charInT = t[t.index(t.startIndex, offsetBy: index)]
        
        if mapS[charInS] == nil {
            mapS[charInS] = charInT
        } else {
            if mapS[charInS] != charInT {
                return false
            }
        }
        
        if mapT[charInT] == nil {
            mapT[charInT] = charInS
        } else {
            if mapT[charInT] != charInS {
                return false
            }
        }
    }
    
    return true
}



//206. Reverse Linked List
/**
 Assume that we have linked list 1 → 2 → 3 → Ø, we would like to change it to Ø ← 1 ← 2 ← 3.
 
 While you are traversing the list, change the current node's next pointer to point to its previous element. Since a node does not have reference to its previous node, you must store its previous element beforehand. You also need another pointer to store the next node before changing the reference. Do not forget to return the new head reference at the end!
 
 */
func reverseList(_ head: ListNode?) -> ListNode? {
    var cursor = head
    var previous: ListNode?
    
    while cursor != nil {
        
        let cursorNext = cursor?.next
        cursor?.next = previous
        previous = cursor
        cursor = cursorNext
    }
    return previous
}


//217. Contains Duplicate
/**
 
 Given an array of integers, find if the array contains any duplicates. Your function should return true if any value appears at least twice in the array, and it should return false if every element is distinct.
 */

func containsDuplicate(_ nums: [Int]) -> Bool {
    
    var set = Set<Int>()
    var count = 0
//    for index in 0..<nums.count {
//        let num = nums[index]
//        if set.contains(num) {
//            return true
//        } else {
//            set.insert(num)
//        }
//    }
    for index in 0..<nums.count {
        let num = nums[index]
        set.insert(num)
        let newCount = set.count
        if newCount == count {
            return true
        }
    }
    return false
}

//219. Contains Duplicate II

/**
 
 Given an array of integers and an integer k, find out whether there are two distinct indices i and j in the array such that nums[i] = nums[j] and the absolute difference between i and j is at most k.
 
 */

/**
 
 这个算法在跑的时候失败了，input[1], 1, 要求返回true 这个算法返回false，但是我觉得程序是对的，一个元素的数组根本没有重复的，
 
 
 网友的explanation
 
 Explanation: It iterates over the array using a sliding window. The front of the window is at i, the rear of the window is k steps back. The elements within that window are maintained using a set. While adding new element to the set, if add() returns false, it means the element already exists in the set. At that point, we return true. If the control reaches out of for loop, it means that inner return true never executed, meaning no such duplicate element was found.
 
 还有网友贴了一个case
 
 [1,2,3,4,5,6,7,8,9,1,10,11,1,12]
 
 3
 
 其中1是重复的，但是，1有两个距离 9， 还有 3  按道理讲说两个元素最大是k, 但是因为第一个距离因为超过了被从set中删掉了，
 
 */
func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
    
    var set = Set<Int>()
    for index in 0..<nums.count {
        
        if index > k {
            //remove element if its distance to nums[i] is not lesser than k
            set.remove(nums[index - k - 1])
        }
        //because all still existed elements is closer than k distance to the num[i], therefore if the add() return false, it means there's a same value element already existed within the distance k, therefore return true.
        if nums.contains(nums[index]) {
            return true
        }
    }
    return false
}


public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}


//226. Invert Binary Tree
//递归要快一些
func invertTree(_ root: TreeNode?) -> TreeNode? {
    if root == nil {
        return root
    }
    var left = root?.left
    root?.left = root?.right
    root?.right = left
    invertTree(root?.left)
    invertTree(root?.right)
    return root
}


//231. Power of Two
/**
 
 Given an integer, write a function to determine if it is a power of two.
 
 Power of 2 means only one bit of n is '1', so use the trick n&(n-1)==0 to judge whether that is the case
 */
func isPowerOfTwo(_ n: Int) -> Bool {
    if n <= 0 {
        return false
    }
    return (n & (n-1)) == 0
}










