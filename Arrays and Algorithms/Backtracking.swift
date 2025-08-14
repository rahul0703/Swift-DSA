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
}
