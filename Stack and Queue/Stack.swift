//
//  Stack&Queue.swift
//  DSA
//
//  Created by Rahul Sureka on 08/08/25.
//

import Foundation

class Stack {
  /*
   Question 1: Dublicate brackets
   Implement a function to check if a given expression has duplicate brackets.
   Solution: The correct way is to check if there are no characters between a pair of brackets (i.e., you pop zero elements before hitting '(')
   */
  func checkDuplicateBrackets(expression: String) -> Bool {
    var stack = [Character]()
    for char in expression {
      if char != ")" {
        stack.append(char)
      } else {
        var count = 0
        while let last = stack.last, last != "(" {
          stack.popLast()
          count += 1
        }
        stack.popLast() // pop the '('
        if count == 0 {
          return true // Found duplicate brackets
        }
      }
    }
    return false // No duplicate brackets found
  }
  
  //checkDuplicateBrackets(expression: "(a)+((b+c))") // true
  //checkDuplicateBrackets(expression: "((a)+(b))") // false
  
  /*
   Question 2: Balanced Parentheses
   Desc: Implement a function to check if a given expression has balanced parentheses.
   Solution: Use a stack to keep track of opening parentheses and ensure they are properly closed.
   */
  
  func isBalancedParantheses(expression: String) -> Bool {
    var stack = [Character]()
    for ch in expression {
      if ch == ")" || ch == "}" || ch == "]" {
        while !stack.isEmpty && stack.last != "(" && stack.last != "{" && stack.last != "[" {
          stack.popLast()
        }
        if stack.isEmpty {
          return false // No matching opening parenthesis
        }
        if ch == ")" && stack.last == "(" ||
            ch == "}" && stack.last == "{" ||
            ch == "]" && stack.last == "[" {
          stack.popLast() // Pop the matching opening parenthesis
        } else {
          return false // Mismatched parentheses
        }
      } else {
        stack.append(ch) // Push opening parentheses onto the stack
      }
    }
    if stack.isEmpty {
      return true // All parentheses are balanced
    } else {
      return false // Some opening parentheses are not closed
    }
  }
  
  //isBalancedParantheses(expression: "([)]")
  
  
  /*
   Question 3: Next greater element to the right
   Desc: Given an array, find the next greater element for each element in the array.
   Sample testcase: [1,3,6,2,8,4,5,7] -> [3,6,8,8,-1,5,7,-1]
   Solution: We can use a stack to keep track of the next greater elements
   */
  
  func nextGreaterElementToRight(arr: [Int]) -> [Int] {
    var solArray: [Int] = []
    var stack: [Int] = []
    var n = arr.count
    
    for i in (0..<n).reversed() {
      if i == n-1 {
        solArray.append(-1) // Last element has no next greater element
      } else {
        while !stack.isEmpty && stack.last! <= arr[i] {
          stack.popLast() //Pop elements that are not greater than the current element
        }
        if stack.isEmpty {
          solArray.append(-1) // No greater element found
        } else {
          solArray.append(stack.last!) // Next greater element found
        }
      }
      stack.append(arr[i]) // Push the current element onto the stack
    }
    return solArray.reversed() // Reverse the result to maintain original order
  }
  
  //nextGreaterElementToRight(arr: [1,3,6,2,8,4,5,7]) // [3,6,8,8,-1,5,7,-1]
  
  /*
   Question 4: Largest area in histogram
   desc: Given an array representing the heights of bars in a histogram, find the largest rectangular area that can be formed.
   Soluton: Find the next smaller element to the left and right for each bar, then calculate the area using these indices.
   Video: https://youtu.be/0do2734xhnU?si=2GX40Uw0x_MHgix9
   */
  func largestAreaInHistogram(heights: [Int]) -> Int {
    var n = heights.count
    var leftSmaller = findLeftSmaller(heights: heights, n: n)
    var rightSmaller = findRightSmaller(heights: heights, n: n)
    var maxArea = 0
    for i in 0 ..< n {
      let width = rightSmaller[i] - leftSmaller[i] - 1
      let area = heights[i] * width
      maxArea = max(maxArea, area)
    }
    return maxArea
  }
  
  private func findLeftSmaller(heights: [Int], n: Int) -> [Int] {
    var stack = [Int]()
    var leftSmaller: [Int] = []
    
    for i in 0 ..< n {
      while !stack.isEmpty && heights[stack.last!] >= heights[i] {
        stack.removeLast()
      }
      if stack.isEmpty {
        leftSmaller.append(-1) // No smaller element to the left
      } else {
        leftSmaller.append(stack.last!) // Index of the last smaller element
      }
      stack.append(i) // Push current index onto the stack
    }
    return leftSmaller
  }
  
  private func findRightSmaller(heights: [Int], n: Int) -> [Int] {
    var stack = [Int]()
    var rightSmaller: [Int] = []
    
    for i in (0 ..< n).reversed() {
      while !stack.isEmpty && heights[stack.last!] >= heights[i] {
        stack.removeLast()
      }
      if stack.isEmpty {
        rightSmaller.append(n) // No smaller element to the right
      } else {
        rightSmaller.append(stack.last!) // Index of the last smaller element
      }
      stack.append(i) // Push current index onto the stack
    }
    return rightSmaller.reversed() // Reverse to maintain original order
  }
  
  //---------------------------------------------------------------------------------
  /*
   Question 5: Sliding window maximum
   Desc: Given an array and a window size, find the maximum element in each sliding window.
   Solution: we calculate the next greater element for each element and then loop for next K element to find the greatest element in the window.
   */
  
  func slidingWindowMaximum(nums: [Int], k: Int) -> [Int] {
    var len = nums.count
    var solutionArray = [Int]()
    //Find the next greater element for each element in the array
    var nextGreaterIndex = findNextGreaterIndex(nums: nums)
    //Loop the array for i = 0 to n-k and find the maximum element in the window
    var j = 0
    for i in 0 ... len - k {
      j = max(i, j)
      while nextGreaterIndex[j] != -1 && nextGreaterIndex[j] < i + k {
        j = nextGreaterIndex[j]
      }
      solutionArray.append(nums[j]) // Append the maximum element in the window
    }
    return solutionArray
  }
  
  private func findNextGreaterIndex(nums: [Int]) -> [Int] {
    var solutionArray = [Int]()
    var stack = [Int]()
    var len = nums.count
    for i in (0 ..< len).reversed() {
      if i == len - 1 {
        solutionArray.append(-1) // Last element has no next greater element
        stack.append(i) // Push the index onto the stack
      } else {
        while !stack.isEmpty && nums[i] > nums[stack.last!] {
          stack.popLast() // Pop elements that are not greater than the current element
        }
        if stack.isEmpty {
          solutionArray.append(-1) // No greater element found
        } else {
          solutionArray.append(stack.last!) // Next greater element found
        }
        stack.append(i) // Push the current index onto the stack
      }
    }
    return solutionArray.reversed()
  }
  var nums = [1,3,1,2,0,5], k = 3
  slidingWindowMaximum(nums: nums, k: k)
  
  
  /*
   Question 6: Inflix evaluation
   */
  func calculate(_ s: String) -> Int {
    var values = [Int]()          // Operand stack
    var ops = [Character]()       // Operator stack
    
    func precedence(_ op: Character) -> Int {
      switch op {
      case "+", "-": return 1
      case "*", "/": return 2
      default: return 0
      }
    }
    
    func applyOp(_ op: Character, _ b: Int, _ a: Int) -> Int {
      switch op {
      case "+": return a + b
      case "-": return a - b
      case "*": return a * b
      case "/": return a / b  // Integer division
      default: return 0
      }
    }
    
    let tokens = Array(s.filter { !$0.isWhitespace })  // remove spaces
    var i = 0
    
    while i < tokens.count {
      let token = tokens[i]
      if token.isNumber {
        var numStr = ""
        while i < tokens.count && tokens[i].isNumber {
          numStr.append(tokens[i])
          i += 1
        }
        var num = Int(numStr)!
        values.append(num)
      } else if token == "(" {
        ops.append(token)
        i += 1
      } else if token == ")" {
        while !ops.isEmpty && ops.last! != "(" {
          let op = ops.removeLast()
          let b = values.removeLast()
          let a = values.removeLast()
          values.append(applyOp(op, b, a))
        }
        ops.removeLast()  // remove '('
        i += 1
      } else if "+-*/".contains(token) {
        while !ops.isEmpty && precedence(ops.last!) >= precedence(token) {
          let op = ops.removeLast()
          let b = values.removeLast()
          let a = values.removeLast()
          values.append(applyOp(op, b, a))
        }
        ops.append(token)
        i += 1
      }
    }
    
    while !ops.isEmpty {
      let op = ops.removeLast()
      let b = values.removeLast()
      let a = values.removeLast()
      values.append(applyOp(op, b, a))
    }
    
    return values.last ?? 0
  }
  
  /*
   Leetcode 150: Evaluate Reverse Polish Notation
   */
  func evalRPN(_ tokens: [String]) -> Int {
    var operands = [Int]()
    var operators = [String]()
    
    func applyOp(_ op: String, _ b: Int, _ a: Int) -> Int {
      switch op {
      case "+": return a + b
      case "-": return a - b
      case "*": return a * b
      case "/": return a / b  // Integer division
      default: return 0
      }
    }
    for char in tokens {
      if let num = Int(char) {
        operands.append(num)
      } else {
        var b = operands.removeLast()
        var a = operands.removeLast()
        
        var ans = applyOp(char, b, a)
        operands.append(ans)
      }
    }
    
    return operands.removeLast()
  }
  
  /*
   Leetcode 224: Basic Calculator
   Very important question.
   Check the negative number handling part.
   We have uniary number 0 before the negative sign.
   */
  func calculate(_ s: String) -> Int {
    func calculate(_ opr: Character, _ a: Int, _ b: Int) -> Int {
      switch opr {
      case "+": return a + b
      case "-": return a - b
      default: return 0
      }
    }
    var array = Array(s)
    var operands = [Int]()
    var operators = [Character]()
    
    var i = 0
    while i < array.count {
      var char = array[i]
      if char == " " {
        i += 1
        continue
      } else if char.isNumber {
        var numStr = ""
        while i < array.count && array[i].isNumber {
          numStr.append(array[i])
          i += 1
        }
        var num = Int(numStr)!
        operands.append(num)
      } else {
        if char == "(" {
          operators.append(char)
        } else if char == "+" || char == "-" {
          //Handle negative number
          var j = i - 1
          while j >= 0 && array[j] == " " {
            j -= 1
          }
          if j < 0 || array[j] == "(" {
            operands.append(0)
          }
          
          if !operators.isEmpty && (operators.last! == "+" || operators.last! == "-") {
            var b = operands.removeLast()
            var a = operands.removeLast()
            var opr = operators.removeLast()
            var ans = calculate(opr, a, b)
            operands.append(ans)
          }
          operators.append(char)
        } else {
          while operators.last! != "(" {
            var b = operands.removeLast()
            var a = operands.removeLast()
            var opr = operators.removeLast()
            var ans = calculate(opr, a, b)
            operands.append(ans)
          }
          //Remove the opening bracket
          operators.removeLast()
        }
        i += 1
      }
    }
    while !operators.isEmpty {
      var b = operands.removeLast()
      var a = operands.removeLast()
      var opr = operators.removeLast()
      var ans = calculate(opr, a, b)
      operands.append(ans)
    }
    
    return operands.removeLast()
  }
  
  
  /*
   Leetcode 907: Sum of Subarray Minimums
   Very Very Important question
   
   For every element i in array
   Lets say for [3,1,2,4]
   arr[i] = 1
   
   now, number of subarrays where arr[i] is minimum is = left * right
   where
    left: no. of subarrays ending at i
    right: no. of subarrays starting at i
   
   Now, how do we calculate the left and right
   Simple:
    left = i - index(left smaller elemement)
    right = index(right smaller element) - i
   
   For our case, 1 is minimum so, left = 1 - (-1) = 2,
                                  right = 4 - 1 = 3
   so, left * right = 2*3 = 6 as [1],[1,2],[1,2,4],[3,1],[3,1,2],[3,1,2,4]
   
   
   */
  func sumSubarrayMins(_ arr: [Int]) -> Int {
    let MOD = 1_000_000_007
    var leftMin = [Int]()
    var rightMin = [Int]()
    
    var stack = [Int]()
    
    for i in 0 ..< arr.count {
      var val = arr[i]
      while !stack.isEmpty && arr[stack.last!] > val {
        stack.removeLast()
      }
      if stack.isEmpty {
        leftMin.append(-1)
      } else {
        leftMin.append(stack.last!)
      }
      stack.append(i)
    }
    
    stack = []
    for i in (0 ..< arr.count).reversed() {
      var val = arr[i]
      while !stack.isEmpty && arr[stack.last!] >= val {
        stack.removeLast()
      }
      if stack.isEmpty {
        rightMin.append(arr.count)
      } else {
        rightMin.append(stack.last!)
      }
      stack.append(i)
    }
    rightMin.reverse()
    var sum = 0
    //Contribution of arr[i] = left * right * arr[i]
    for i in 0 ..< arr.count {
      var left = i - leftMin[i]
      var right = rightMin[i] - i
      var num = arr[i]
      let contribution = ((left % MOD) * (right % MOD)) % MOD
      let total = (contribution * (num % MOD)) % MOD
      sum = (sum + total) % MOD
    }
    
    return sum
  }
}
