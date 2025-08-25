//
//  Backtracking.swift
//  DSA
//
//  Created by Rahul Sureka on 08/08/25.
//

import Foundation

class Backtracking {
  /*
   Question 1: N-Queens Problem
   Solution:
   1. As, no 2 or more queen can be placed in same row or column or diagonal. We need to check this.
   2. Use backtracking to solve the problem.
   */
  func printAllNQueenPossibility(n: Int) {
    var matrix: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: n)
    fillNQueenMatrix(matrix: &matrix, n: n, row: 0, pathSoFar: "")
  }
  
  private func fillNQueenMatrix(matrix: inout [[Int]], n: Int, row: Int, pathSoFar: String) {
    if row == n {
      print(pathSoFar)
      return
    }
    
    for col in 0 ..< n {
      if isSafe(matrix: matrix, row, col, n) {
        matrix[row][col] = 1 // Place the queen
        fillNQueenMatrix(matrix: &matrix, n: n, row: row + 1, pathSoFar: pathSoFar + "(\(row), \(col)) ")
        matrix[row][col] = 0 // Backtrack by removing the queen
      }
    }
  }
  
  private func isSafe(matrix: [[Int]], _ row: Int, _ col: Int, _ n: Int) -> Bool {
    //Check column
    for j in 0 ..< row {
      if matrix[j][col] == 1 {
        return false // upper row already has a queen
      }
    }
    //Check upper left diagonals
    for j in 0 ..< min(row, col) {
      if matrix[row-j][col-j] == 1 {
        return false // Upper left diagonal has a queen
      }
    }
    
    //check upper right diagonals
    for j in 0 ..< min(row, n - col - 1) {
      if matrix[row-j][col+j] == 1 {
        return false // Upper right diagonal has a queen
      }
    }
    return true
  }
  
  
  /*
   Question 2: Knight tour problem.
   Print all path from top left to bottom right of a n x n matrix. With no cell being visited twice.
   */
  let rowMoves = [2, 1, -1, -2, -2, -1, 1, 2]
  let colMoves = [1, 2, 2, 1, -1, -2, -2, -1]
  
  func printAllKnightTourPossibility(n: Int) {
    var matrix: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: n)
    var visited: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: n)
    
    printAllKnightTourPossibility(matrix: &matrix, visited: &visited, n: n, row: 0, col: 0, pathSoFar: "")
  }
  
  private func printAllKnightTourPossibility(matrix: inout [[Int]], visited: inout [[Int]], n: Int, row: Int, col: Int, pathSoFar: String) {
    if row < 0 || row >= n || col < 0 || col >= n || visited[row][col] == 1 {
      return // Out of bounds or already visited
    }
    if row == n - 1 && col == n - 1 {
      print(pathSoFar + "(\(row), \(col))")
      return // Reached the bottom right corner
    }
    
    visited[row][col] = 1 // Mark the cell as visited
    matrix[row][col] = 1 // Mark the cell in the matrix
    for i in 0 ..< 8 {
      printAllKnightTourPossibility(matrix: &matrix, visited: &visited, n: n, row: row + rowMoves[i], col: col + colMoves[i], pathSoFar: pathSoFar + "(\(row), \(col)) ")
    }
    visited[row][col] = 0 // Backtrack by marking the cell as unvisited
  }
  
  
  /*
   Question 3: Print Abbrevations
   Print all possible abbreviations of a given word.
   */
  func printAllAbbreviations(word: String) {
    var length = word.count
    var wordArray = Array(word)
    var array = getAllAbbreviations(word: wordArray, index: 0, length: length)
    for abbreviation in array {
      print(abbreviation)
    }
  }
  private func getAllAbbreviations(word: [Character], index: Int, length: Int) -> [String] {
    var answer = [String]()
    if index == length {
      answer.append("")
      return answer
    }
    
    var prevArray = getAllAbbreviations(word: word, index: index + 1, length: length)
    for abbreviation in prevArray {
      if !abbreviation.isEmpty {
        let firstChar = abbreviation.first!
        if firstChar.isNumber {
          let number = Int(String(firstChar))!
          answer.append("\(number + 1)" + String(abbreviation.dropFirst()))
        } else {
          answer.append("1" + String(abbreviation))
        }
        answer.append(String(word[index]) + abbreviation)
      } else {
        answer.append(String(word[index]) + abbreviation)
        answer.append("1" + abbreviation)
      }
    }
    return answer
  }
  
  // Example usage:
  printAllAbbreviations(word: "pep")
  
  /*
   Question 4: Joseph circles problem.
   Desc: Given a number n, and a number k, find the last person remaining in the circle after repeatedly removing every k-th person.
   Approch: We will use linked list to solve this problem as it is efficient for removing elements.
   */
  class Node {
    var value: Int
    var next: Node?
    var prev: Node?
    
    init(value: Int) {
      self.value = value
    }
  }
  
  func josephusProblem(n: Int, k: Int) -> Int {
    if n == 0 { return 0 }
    let head = Node(value: 1)
    var prev = head
    for i in 2...n {
      let node = Node(value: i)
      prev.next = node
      node.prev = prev
      prev = node
    }
    prev.next = head
    head.prev = prev
    
    var current = head
    var size = n
    while size > 1 {
      for _ in 1..<k {
        current = current.next!
      }
      // Remove current
      current.prev?.next = current.next
      current.next?.prev = current.prev
      current = current.next!
      size -= 1
    }
    return current.value
  }
  
  //Leetcode 17: Letter Combinations of a Phone Number
  func letterCombinations(_ digits: String) -> [String] {
    var charArray = Array(digits)
    var idx = 0
    var length = digits.count
    var dict: [Int: [String]] = [2: ["a", "b","c"], 3:["d","e","f"], 4:["g","h","i"], 5:["j","k","l"],6:["m","n","o"],7:["p","q","r","s"],8:["t","u","v"],9:["w","x","y","z"]]
    
    func backtracking(_ idx: Int) -> [String] {
      if idx >= length {
        return []
      }
      
      var subArray = backtracking(idx + 1)
      var num = Int(String(charArray[idx]))!
      var answer: [String] = []
      for char in dict[num]! {
        if subArray.count > 0 {
          for subAns in subArray {
            answer.append(char + subAns)
          }
        } else {
          answer.append(char)
        }
      }
      return answer
    }
    var answer = backtracking(idx)
    return answer
  }
  
  /*
   Leetcode 22: Generate Parentheses
   Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.
   Approach: use backtracking to generate all combinations of parentheses.
   open < n, close < open
   */
  func generateParenthesis(_ n: Int) -> [String] {
    var stack: [String] = []
    var res: [String] = []
    
    func backtrack(_ start: Int, _ end: Int) {
      if start == end && end == n {
        res.append(stack.joined())
        return
      }
      
      if start < n {
        stack.append("(")
        backtrack(start + 1, end)
        stack.removeLast()
      }
      
      if end < start {
        stack.append(")")
        backtrack(start, end + 1)
        stack.removeLast()
      }
    }
    
    backtrack(0,0)
    return res
  }
  
  /*
   Leetcode 78: Subsets
   */
  func subsets(_ nums: [Int]) -> [[Int]] {
    var len = nums.count
    
    func backTrack(_ n: Int) -> [[Int]] {
      if n == 0 {
        return [[]]
      }
      var answer = [[Int]]()
      var subArray = backTrack(n-1)
      for subAns in subArray {
        answer.append(subAns)
        var newAnswer = subAns
        newAnswer.append(nums[n-1])
        answer.append(newAnswer)
      }
      
      return answer
    }
    return backTrack(len)
  }
  
  /*
   Leetcode 39: Combination Sum
   */
  func combinationSum(_ can: [Int], _ tar: Int) -> [[Int]] {
    var ans = [[Int]]()
    var len = can.count
    var subAns = [Int]()
    var hashset = Set<[Int]>()
    func backtrack(_ idx: Int, _ sum: Int) {
      if sum == tar {
        var clone = subAns
        if !hashset.contains(clone) {
          hashset.insert(clone)
          ans.append(clone)
        }
        return
      }
      
      if idx == len || sum > tar {
        return
      }
      
      var num = can[idx]
      
      subAns.append(num)
      backtrack(idx, sum + num)
      backtrack(idx + 1, sum + num)
      subAns.removeLast()
      backtrack(idx + 1, sum)
    }
    
    backtrack(0, 0)
    return ans
  }
  
  
  /*
   Leetcode 40: Combination Sum II
   Very important question.
   */
  func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
    let nums = candidates.sorted()
    var path: [Int] = []
    var ans: [[Int]] = []
    
    func dfs(_ start: Int, _ remain: Int) {
      if remain == 0 {
        ans.append(path)
        return
      }
      var i = start
      while i < nums.count {
        let v = nums[i]
        if v > remain { break }                    // pruning by sorted order
        
        // skip duplicates at THIS depth
        if i > start && nums[i] == nums[i - 1] {
          i += 1
          continue
        }
        
        path.append(v)
        dfs(i + 1, remain - v)                     // i+1 because each number can be used once
        path.removeLast()
        i += 1
      }
    }
    
    dfs(0, target)
    return ans
  }
  
  /*
   Leetcode 216: Combination Sum III
   */
  func combinationSum3(_ k: Int, _ n: Int) -> [[Int]] {
    var ans = [[Int]]()
    var subAns = [Int]()
    
    func recursion(_ idx: Int, _ sum: Int, _ count: Int) {
      if sum == n && idx == 10 && count == k {
        var clone = subAns
        ans.append(clone)
      }
      
      if sum > n || count > k || idx > 9 {
        return
      }
      
      subAns.append(idx)
      recursion(idx + 1, sum + idx, count + 1)
      subAns.removeLast()
      recursion(idx + 1, sum, count)
    }
    recursion(1, 0, 0)
    return ans
  }
  
  /*
   Leetcode 93: Restore IP Addresses
   */
  func restoreIpAddresses(_ s: String) -> [String] {
    var len = s.count
    var ans = [String]()
    if len < 4 {
      return ans
    }
    func isValidStringFinal(_ str: String) -> Bool {
      let parts = str.split(separator: ".", omittingEmptySubsequences: false)
      for part in parts {
        if part.isEmpty || part.count > 3 || (part.hasPrefix("0") && part.count > 1) {
          return false
        }
        let num = Int(part)!
        if num > 255 {
          return false
        }
      }
      print(str)
      return true
    }
    func backtrack(_ idx: Int, _ count: Int, _ str: String) {
      if idx == len {
        if count == 3 && isValidStringFinal(str) {
          ans.append(str)
        }
        return
      }
      if count > 3 {
        return
      }
      var firstHalf = String(str.prefix(idx+count))
      var secondHalf = String(str.dropFirst(idx+count))
      var newString = firstHalf + "." + secondHalf
      backtrack(idx + 1, count + 1, newString)
      backtrack(idx+1, count, str)
    }
    
    backtrack(0, 0, s)
    return ans
  }
  
  /*
   Leetcode 79: Word Search
   Very important question.
   */
  func exist(_ board: [[Character]], _ word: String) -> Bool {
    var lenX = board.count
    var lenY = board[0].count
    var visited = Array(repeating: Array(repeating: false, count: lenY), count: lenX)
    var next = [(1,0),(-1,0),(0,1),(0,-1)]
    
    func backtrack(_ x: Int, _ y: Int, _ visited: inout [[Bool]], _ str: inout [Character]) -> Bool {
      var char = board[x][y]
      
      str.append(char)
      visited[x][y] = true
      
      if String(str) == word {
        return true
      }
      
      var len = str.count
      if len >= word.count {
        str.removeLast()
        visited[x][y] = false
        return false
      }
      
      if String(word.prefix(len)) == String(str) {
        for i in 0 ..< 4 {
          var nextX = x + next[i].0
          var nextY = y + next[i].1
          
          if nextX >= 0 && nextX < lenX && nextY >= 0 && nextY < lenY && !visited[nextX][nextY] {
            var ans = backtrack(nextX, nextY, &visited, &str)
            if ans {
              return true
            }
          }
        }
      }
      visited[x][y] = false
      str.removeLast()
      return false
    }
    
    
    var array = [Character]()
    for i in 0 ..< lenX {
      for j in 0 ..< lenY {
        if String(board[i][j]) == String(word.prefix(1)) {
          var ans = backtrack(i, j, &visited, &array)
          if ans {
            return true
          }
        }
      }
    }
    return false
  }
  
}
