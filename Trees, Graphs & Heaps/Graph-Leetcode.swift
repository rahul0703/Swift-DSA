//
//  Graph-Leetcode.swift
//  DSA
//
//  Created by Rahul Sureka on 10/08/25.
//

import Foundation

class GraphLeetCode {
  /*
   Question Leetcode 286
   You are given an m x n grid rooms initialized with these three possible values:
   -1 representing a wall or an obstacle.
   0 representing a gate.
   INF (2³¹ - 1) representing an empty room.
   Fill each empty room with the distance to its nearest gate. If it is impossible to reach a gate, leave it as INF.
   You may assume that the input grid has at least one gate.
   */
  func wallsAndgates(_ rooms: inout [[Int]]) {
    var queue: [(Int, Int, Int)] = []
    
    for i in 0 ..< rooms.count {
      for j in 0 ..< rooms[0].count {
        if rooms[i][j] == 0 {
          queue.append((i, j, 0)) // Add gate coordinates to the queue
        }
      }
    }
    var visited: [[Int]] = Array(repeating: Array(repeating: 0, count: rooms[0].count), count: rooms.count)
    while(!queue.isEmpty) {
      //Remove
      var popped = queue.removeFirst()
      var x = popped.0
      var y = popped.1
      var cost = popped.2
      //Check if popped is a wall or already visited
      if visited[x][y] == 1 {
        continue
      }
      //Mark visited
      visited[x][y] = 1
      //Work
      rooms[x][y] = cost
      //Add neighbours to queue
      var directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
      for directions in directions {
        var newX = x + directions.0
        var newY = y + directions.1
        
        if newX >= 0 && newX < rooms.count && newY >= 0 && newY < rooms[0].count && rooms[newX][newY] != -1 && visited[newX][newY] == 0 {
          queue.append((newX, newY, cost + 1))
        }
      }
    }
  }
  
  /*
   Leetcode 994: Rotting Oranges
   */
  func orangesRotting(_ grid: [[Int]]) -> Int {
    var maxTime = 0
    var queue: [(Int, Int, Int)] = []
    var visited = Array(repeating: Array(repeating: 0, count: grid[0].count), count: grid.count)
    
    for i in 0 ..< grid.count {
      for j in 0 ..< grid[0].count {
        if grid[i][j] == 2 {
          queue.append((i, j, 0)) // Add rotten orange coordinates to the queue
        }
      }
    }
    while !queue.isEmpty {
      //Remove
      var popped = queue.removeFirst()
      var x = popped.0
      var y = popped.1
      var time = popped.2
      //Check visited
      if visited[x][y] == 1 {
        continue // Already visited
      }
      //Mark visited
      visited[x][y] = 1
      //work
      maxTime = max(maxTime, time) // Update max time
      //Add ngrs
      var directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
      for direction in directions {
        var newX = x + direction.0
        var newY = y + direction.1
        
        if newX >= 0 && newX < grid.count && newY >= 0 && newY < grid[0].count && grid[newX][newY] == 1 && visited[newX][newY] == 0 {
          queue.append((newX, newY, time + 1)) // Add fresh orange to the queue
        }
      }
    }
    
    for i in 0 ..< grid.count {
      for j in 0 ..< grid[0].count {
        if grid[i][j] == 1 && visited[i][j] == 0 {
          return -1 // If any fresh orange is left, return -1
        }
      }
    }
    return maxTime
  }
  
  /*
   Question Leetcode 127: Word Ladder
   */
  func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
    var hashSet = Set<String>()
    var visited = Set<String>()
    for word in wordList {
      hashSet.insert(word)
    }
    var queue: [(String, Int)] = []
    var n = beginWord.count
    queue.append((beginWord, 1))
    
    while !queue.isEmpty {
      //Remove
      var popped = queue.removeFirst()
      var poppedStr = popped.0
      var cost = popped.1
      //Check Visited
      if visited.contains(poppedStr) {
        continue
      }
      //Mark Visited
      visited.insert(poppedStr)
      //Work
      if poppedStr == endWord {
        return cost
      }
      cost += 1
      //Add ngrs
      for i in 0 ..< n {
        var array = Array(poppedStr)
        let digit = Int(array[i].asciiValue! - Character("a").asciiValue!)
        
        for j in 1 ..< 26 {
          let offset = (digit + j) % 26
          let baseAscii = Int(Character("a").asciiValue!)
          let newAscii = baseAscii + offset
          let newChar = Character(UnicodeScalar(newAscii)!)
          
          array[i] = newChar
          let ngr = String(array)
          // Use `neighbor` as the modified string
          if hashSet.contains(ngr) && !visited.contains(ngr) {
            print(ngr)
            queue.append((ngr, cost))
          }
        }
      }
    }
    return 0
  }
  
  /*
   Question Leetcode 752: Open the Lock
   */
  func openLock(_ deadends: [String], _ target: String) -> Int {
    var visited = Set<String>()
    var blocked = Set<String>()
    var queue: [(String, Int)] = []
    
    for str in deadends {
      blocked.insert(str)
    }
    if blocked.contains("0000") || blocked.contains(target) {
      return -1
    }
    queue.append(("0000", 0))
    while !queue.isEmpty {
      //Remove
      var popped = queue.removeFirst()
      var poppedStr = popped.0
      var cost = popped.1
      //Check Visited
      if visited.contains(poppedStr) {
        continue
      }
      //Mark Visited
      visited.insert(poppedStr)
      //Work
      if poppedStr == target {
        return cost
      }
      var newCost = cost+1
      //Add Ngrs
      for i in 0 ..< 4 {
        var array = Array(poppedStr)
        var digit = Int(String(array[i]))!
        
        for delta in [-1, 1] {
          var newDigit = (digit + delta + 10)%10
          var newState = array
          newState[i] = Character(String(newDigit))
          let ngr = String(newState)
          if blocked.contains(ngr) {
            continue
          }
          queue.append((ngr, newCost))
        }
      }
    }
    return -1
  }
}

