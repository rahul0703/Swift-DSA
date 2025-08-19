//
//  Arrays.swift
//  DSA
//
//  Created by Rahul Sureka on 08/08/25.
//

import Foundation

class Arrays {
  import UIKit
  
  /*
   Question 1: Find GCD and LCM of two numbers
   Solution: Find GCD of 2 numbers and diving by product of two numbers gives LCM
   */
  func gcd(a: Int, b: Int) -> Int {
    var a = a
    var b = b
    if a < b {
      return gcd(a: b, b: a)
    }
    while b != 0 {
      let temp = b
      b = a % b
      a = temp
    }
    return a
  }
  
  func lcm(a: Int, b: Int) -> Int {
    var lcm = (a / gcd(a: a, b: b)) * b
    return lcm
  }
  
  /*
   Question 2: Prime factionization of number
   Solution:
   1. Start with the smallest prime number (2).
   2. After that, start with odd numbers starting from 3 and increament by 2 and end sqroot of number.
   3. If number is still greater than 1, then it is a prime number.
   */
  
  func primeFactionization(of number: Int) -> [Int] {
    var factors: [Int] = []
    var number = number
    while number % 2 == 0 {
      factors.append(2)
      number /= 2
    }
    var i = 3
    while i * i <= number {
      while number % i == 0 {
        factors.append(i)
        number /= i
      }
      i += 2 // Increment by 2 to check only odd numbers
    }
    if number > 1 {
      factors.append(number) // If number is still greater than 1, it is a prime factor
    }
    return factors
  }
  
  /*
   Question 3: Spiral Printing of matrix
   */
  func printSpiralMatrix(_ matrix: [[Int]]) -> [Int] {
    var result: [Int] = []
    var rowSize = matrix.count
    var colSize = matrix[0].count
    
    var top = 0
    var bottom = rowSize - 1
    var left = 0
    var right = colSize - 1
    
    while top <= bottom && left <= right {
      for i in left...right {
        result.append(matrix[top][i]) // Traverse from left to right
      }
      top += 1
      
      for i in top...bottom {
        result.append(matrix[i][right]) // Traverse from top to bottom
      }
      right -= 1
      
      if top <= bottom {
        for i in (left...right).reversed() {
          result.append(matrix[bottom][i]) // Traverse from right to left
        }
        bottom -= 1
      }
      
      if left <= right {
        for i in (top...bottom).reversed() {
          result.append(matrix[i][left]) // Traverse from bottom to top
        }
        left += 1
      }
    }
    
    return result
  }
  
  /*
   Leetcode 33: Search in Rotated and Sorted Array
   Approach: 1. For every half, one side will be sorted and other will not be.
   2. Find the sorted half and check if the target lies in the sorted half
   */
  func search(_ n: [Int], _ t: Int) -> Int {
    //For every half check for the sorted half and check if the node lies in that sorted half
    var lhs = 0
    var rhs = n.count - 1
    
    while lhs <= rhs {
      var mid = (rhs-lhs)/2 + lhs
      var val = n[mid]
      if val == t {
        return mid
      }
      //Check for sorted side
      if n[lhs] <= val {
        //If sorted, check the bouds
        if t >= n[lhs] && t < n[mid] {
          rhs = mid - 1
        } else {
          lhs = mid + 1
        }
      } else {
        //If sorted check the bounds
        if t > n[mid] && t <= n[rhs] {
          lhs = mid + 1
        } else {
          rhs = mid - 1
        }
      }
    }
    return -1
  }
  
  /*
   Find single element in sorted array where every element appear twice
   
   Approach: lets say array is 1,1,2,2,4,5,5,6,6,7,7
   
   here, if you carefully observe, on left side of the single element, the pair appear in (even, odd) index ex: (0,1),(2,3)
   but on the right side of the single element th element appear in (odd,even) index ex: (5,6),(7,8) etc.
   We can use this property to eleminiate the search space.
   */
  func findSingleElement(_ arr: [Int]) -> Int {
    var length = arr.count
    var lhs = 0
    var rhs = length - 1
    if length == 1 {
      return arr[0]
    }
    while (lhs <= rhs) {
      var mid = (rhs - lhs)/2 + lhs
      
      //Check for the space
      if mid == 0 {
        if arr[mid] != arr[mid + 1] {
          return arr[mid]
        } else {
          lhs = mid + 1
        }
      } else if mid == length - 1 {
        if arr[mid] != arr[mid - 1] {
          return arr[mid]
        } else {
          rhs = mid - 1
        }
      } else {
        //Check for left and right side
        if arr[mid] != arr[mid -1] && arr[mid] != arr[mid + 1] {
          return arr[mid] // found mid
        }
        if mid % 2 == 0 {
          if arr[mid + 1] == arr[mid] {
            lhs = mid + 2 // Move to the right side
          } else {
            rhs = mid - 2 //Move to the left
          }
        } else {
          if arr[mid] == arr[mid - 1] {
            lhs = mid + 1
          } else {
            rhs = mid - 1
          }
        }
      }
    }
    return -1
  }
  
  /*
   Find peak element in an array.
   Approach: The left side of peak element will have elements in increasing order and right side will have elements in dec order.
   we can use this to eleminate the search space.
   */
  func findPeakElement(_ arr: [Int]) -> Int {
    var length = arr.count
    
    if length == 1 {
      return arr[0] //Only 1 element
    }
    var lhs = 0
    var rhs = length - 1
    
    while lhs <= rhs {
      var mid = (rhs - lhs)/2 + lhs
      
      if mid == 0 {
        if arr[mid] > arr[mid + 1] {
          return arr[mid]
        } else {
          lhs = mid + 1
        }
      } else if mid == length - 1 {
        if arr[mid] > arr[mid - 1] {
          return arr[mid]
        } else {
          rhs = mid - 1
        }
      } else {
        if arr[mid] > arr[mid - 1] && arr[mid] > arr[mid + 1] {
          return arr[mid]
        } else if arr[mid] > arr[mid - 1] {
          lhs = mid + 1
        } else {
          rhs = mid - 1
        }
      }
    }
    return -1 //No peak found
  }
  
  /*
   Leetcode 875: Koko Eating Bananas
   Find the minimum speed at which koko can eat all the bananas in a given hours.
   Approach:
   lets say an array as [2,3,5,6,1,9,4]
   And hours as 8: so, max speed can be 9 and it will take 7 hours to eat all the bananas
   min speed can be total as 30/8 = 4. At speed of 4 this take 11 hours to eat all.
   1. The max speed is the maximum number of bananas in a pile. This will take time as length of array.
   2. The min speed should be 1
   3. The answer lies between min and max speed.
   */
  func koKoEatingBananas(_ bananas: [Int], _ hours: Int) -> Int {
    var length = bananas.count
    if hours < length {
      return -1
    }
    
    var maxSpeed = bananas.max()!
    var minSpeed = 1
    var answer = maxSpeed
    
    func calculateTime(_ speed: Int) -> Int {
      var time = 0
      for banana in bananas {
        time += banana % speed == 0 ? (banana / speed) : (banana / speed) + 1
      }
      return time
    }
    
    while minSpeed <= maxSpeed {
      var midSpeed = (maxSpeed - minSpeed)/2 + minSpeed
      
      var time = calculateTime(midSpeed)
      
      if time <= hours {
        answer = midSpeed
        maxSpeed = midSpeed - 1
      } else {
        minSpeed = midSpeed + 1
      }
    }
    return answer
  }
  
  /*
   Leetcode 1482: Minimum Number of Days to Make m Bouquets
   */
  func minDays(_ arr: [Int], _ m: Int, _ k: Int) -> Int {
    var reqFlowers = m * k
    var length = arr.count
    
    if length < reqFlowers {
      return -1
    }
    
    var lhs = arr.min()!
    var rhs = arr.max()!
    var minDays = rhs
    
    func ifPossible(_ day: Int) -> Bool {
      var count = 0
      var pointer = 0
      
      for i in 0 ..< length {
        if arr[i] <= day {
          pointer += 1
        } else {
          pointer = 0
        }
        
        if pointer == k {
          count += 1
          pointer = 0
        }
      }
      if count >= m {
        return true
      }
      return false
    }
    
    while lhs <= rhs {
      var mid = (rhs - lhs)/2 + lhs
      if ifPossible(mid) {
        minDays = min(minDays, mid)
        rhs = mid - 1
      } else {
        lhs = mid + 1
      }
    }
    return minDays
  }
  
  /*
   Leetcode 1011: Capacity To Ship Packages Within D Days
   */
  func shipWithinDays(_ w: [Int], _ d: Int) -> Int {
    var len = w.count
    if len == 0 {
      return 0
    }
    
    var lhs = w.max()!
    var rhs = w.reduce(0, +)
    var reqW = rhs
    
    func ifPossible(_ weight: Int) -> Bool {
      var count = 1
      var pointer = weight
      for i in 0 ..< len {
        if pointer < w[i] {
          pointer = weight
          count += 1
        }
        pointer -= w[i]
      }
      if count <= d {
        return true
      }
      return false
    }
    
    while lhs <= rhs {
      var mid = (rhs - lhs)/2 + lhs
      
      if ifPossible(mid) {
        reqW = min(reqW, mid)
        rhs = mid - 1
      } else {
        lhs = mid + 1
      }
    }
    return reqW
  }
  
  /*
   Agressive Cows: You are given positions of n stalls along a straight line, and you want to place k cows in these stalls such that the minimum distance between any two cows is maximized.
   
   The min dist between 2 cows will be 1
   the max dist between any 2 cows will be (max - min) as 1st cow can be placed at starting and 2nd at the end.
   */
  func agreesiveCows(_ stalls: [Int], _ k: Int) -> Int {
    let stalls = stalls.sorted()
    var len = stalls.count
    if k <= 1 || len < k { //No 2 cows can be in same stall
      return -1
    }
    
    func ifPossible(_ dist: Int) -> Bool {
      var count = 1 // First cow placed at first stall
      var last = stalls[0]
      
      var i = 1
      while i < len {
        if stalls[i] - last >= dist {
          count += 1 // Place the cow
          last = stalls[i]
        }
        i += 1
      }
      if count >= k {
        return true // If we can place k cows with at least 'dist' distance
      }
      return false
    }
    
    var lhs = 1 // Minimum distance between cows
    var rhs = stalls[len - 1] - stalls[0]
    var answer = 0
    while lhs <= rhs {
      var mid = (rhs - lhs)/2 + lhs
      
      if ifPossible(mid) {
        answer = max(answer, mid) // Update the answer if possible
        lhs = mid + 1 // Try for larger distance
      } else {
        rhs = mid -1 // Try for smaller distance
      }
    }
    
    return answer
  }
  
  /*
   Distrubte n books to m students such that the maximum number of pages assigned to a student is minimized.
   Approach: The min pages assigned to a student will be 1 and max will be sum
   Lets the array for books be [10, 20, 30, 25, 15, 40, 50, 60, 70, 80] and students be 4.
   lets we distrubute the books as follows: 1st- 10 and 20, 2nd- 30, 3rd=25,15, 4th-40,50,60,70,80
   Here, the max pages assigned is 300, but we need to minimize this maximum number.
   A classic min(maximum) problem.
   
   Solution: Here the minimum pages assigned to a student will be maximum of books[i] as each one should get one book. And the maximum will be sum of all books.
   Edge cases: if students > num of books, then return -1 as we cannot assign more students than books.
   Assumptio
   */
  func distributeBooks(_ books: [Int], _ m: Int) -> Int {
    var len = books.count
    var books = books.sorted()
    if len < m || m == 0 || len == 0 {
      return -1
    }
    var lhs = books.max()!
    var rhs = books.reduce(0, +)
    var answer = Int.max
    
    func ifPossible(_ pages: Int) -> Bool {
      var count = 1 // Start with one student
      var pointer = pages
      for i in 0 ..< len {
        if pointer < books[i] {
          count += 1 // Need to assign to new student
          pointer = pages // Reset pointer to pages
        }
        pointer -= books[i] // Assign the book to the current student
      }
      return count <= m // If we can assign books to m students with max pages as 'pages'
    }
    
    while lhs <= rhs {
      var mid = (rhs - lhs)/2 + lhs
      if ifPossible(mid) {
        answer = min(answer, mid) // Update the answer if possible
        rhs = mid - 1 // Try for smaller maximum pages
      } else {
        lhs = mid + 1 // Try for larger maximum pages
      }
    }
    return answer
  }
  
  
  /*
   Median of 2 sorted arrays
   Approach: Lets say we have arrays as A = [1, 3, 8, 9, 15] and B = [7, 11, 18, 19, 21]
   Here, ths median will be 10 as after merging the array will be [1, 3, 7, 8, 9, 11, 15, 18, 19, 21] as (9+11)/2 = 10.
   and for arrays as A = [1, 3, 8, 9, 15] and B = [7, 11, 18, 19] will be 8 as after merging the array will be [1, 3, 7, 8, 9, 11, 15, 18, 19] and median is 8.
   
   We have to know 2 things, if length_1 + length_2 = even then median will be (mid1 + mid2)/2 and for odd length return mid element.
   
   Solution: As we need to find the mid from 2 sorted arrays, we can use binary search.
   For size of 10 as 5,5 lets say we take 2 elements from array a then we need to take 3 elements from array b. And check if the 2nd element in array a is less than equal to 3rd element in array b.
   For size as 9 with 4 and 5, if we take 2 elements from array a then we need take (9)/2 - 2 = 2 elements from array b and check if 2nd element in array a is less than equal to 3rd element in array b. If yes, return the max
   */
  func medianOf2SortedArrays(_ a: [Int], _ b: [Int]) -> Double {
    let A = a, B = b
    let m = A.count, n = B.count
    
    // Ensure A is the smaller array
    if m > n {
      return findMedianSortedArrays(B, A)
    }
    
    //I can pick-up 0 elements from A or can pick all the elements from A. Therefore the low = 0 and high = length which is m
    var low = 0, high = m
    let total = m + n
    
    while low <= high {
      //partitionA denotes how many elements we are picking from array A and not the index.
      let partitionA = (low + high) / 2
      //partitionB denotes how many elements we are picking from array B and not the index.
      let partitionB = (total + 1) / 2 - partitionA
      
      //Now we need to find the value of elements we are picking from both arrays (min and max)
      //If we pick 0 elements from A, the maxLeftA will be Int.min or elements at -1 index as it is 0 based array.
      let maxLeftA = (partitionA == 0) ? Int.min : A[partitionA - 1]
      //If we pick all elements from A, the minRightA will be Int.max or elements at m index as it is 0 based array.
      let minRightA = (partitionA == m) ? Int.max : A[partitionA]
      
      //Similar logic as A
      let maxLeftB = (partitionB == 0) ? Int.min : B[partitionB - 1]
      let minRightB = (partitionB == n) ? Int.max : B[partitionB]
      
      //Check if we find the median.
      if maxLeftA <= minRightB && maxLeftB <= minRightA {
        // Found correct partition
        if total % 2 == 0 {
          return Double(max(maxLeftA, maxLeftB) + min(minRightA, minRightB)) / 2.0
        } else {
          return Double(max(maxLeftA, maxLeftB))
        }
      } else if maxLeftA > minRightB {
        high = partitionA - 1
      } else {
        low = partitionA + 1
      }
    }
  }
  
  /*
   Find Kth element in 2 sorted arrays
   */
  func kthOf2SortedArrays(_ a: [Int], _ b: [Int], _ k: Int) -> Double {
    let A = a, B = b
    let m = A.count, n = B.count
    
    // Ensure A is the smaller array
    if m > n {
      return kthOf2SortedArrays(B, A, k)
    }
    
    //I can pick-up 0 elements from A or can pick all the elements from A. Therefore the low = 0 and high = length which is m
    var low = 0, high = m
    let total = m + n
    
    while low <= high {
      //partitionA denotes how many elements we are picking from array A and not the index.
      let partitionA = (low + high) / 2
      //partitionB denotes how many elements we are picking from array B and not the index.
      let partitionB = k - partitionA
      
      //Now we need to find the value of elements we are picking from both arrays (min and max)
      //If we pick 0 elements from A, the maxLeftA will be Int.min or elements at -1 index as it is 0 based array.
      let maxLeftA = (partitionA == 0) ? Int.min : A[partitionA - 1]
      //If we pick all elements from A, the minRightA will be Int.max or elements at m index as it is 0 based array.
      let minRightA = (partitionA == m) ? Int.max : A[partitionA]
      
      //Similar logic as A
      let maxLeftB = (partitionB == 0) ? Int.min : B[partitionB - 1]
      let minRightB = (partitionB == n) ? Int.max : B[partitionB]
      
      if maxLeftA <= minRightB && maxLeftB <= minRightA {
        return max(maxLeftA, maxLeftB)
      } else if maxLeftA > minRightB {
        high = partitionA - 1
      } else {
        low = partitionA + 1
      }
    }
  }
}
