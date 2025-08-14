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
}
