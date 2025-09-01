//
//  Greedy.swift
//  DSA
//
//  Created by Rahul Sureka on 09/08/25.
//

import Foundation

class Greedy {
  /*
   Question: Leetcode 45, Min Jump 2
   Desc:
    Each element nums[i] represents the maximum length of a forward jump from index i. In other words, if you are at index i, you can jump to any index (i + j)
    Return the minimum number of jumps to reach index n - 1. The test cases are generated such that you can reach index n - 1.
   */
  func jump(_ nums: [Int]) -> Int {
    var count = nums.count
    var minArray = Array(repeating: Int.max, count: count)
    minArray[0] = 0
    for i in 0 ..< count - 1 {
      var jump = nums[i]
      for j in 0 ... jump {
        if i+j < count {
          minArray[i+j] = min(minArray[i+j], minArray[i] + 1)
        }
      }
    }
    return minArray[count-1]
  }
  
  /*
   Question: Leetcode 435, Given an array of intervals intervals where intervals[i] = [starti, endi],
   return the minimum number of intervals you need to remove to make the rest of the intervals non-overlapping.
   
   Approcah:
    Step 1: Sort on basis of end time of intervals and if end time is same then sort on basis of start time.
    Step 2: Iterate through the intervals and check if current interval start time is greater than prev interval end time.
        if yes, move the current interval index forward and increase the answer count.
            j++, count++
        if no, then make prev interval as curr interval and move the current interval index forward.
            i = j
            j++
   */
  func eraseOverlapIntervals(_ intervals: [[Int]]) -> Int {
    var count = intervals.count
    if count == 0 || count == 1 {
      return 0
    }
    var sortedIntervals = intervals.sorted {
      if $0[1] == $1[1] {
        return $0[0] < $1[0]
      }
      return $0[1] < $1[1]
    }
    var answer = 0
    var i = 0
    var j = 1
    while j < count {
      var intervalFirst = sortedIntervals[i]
      var intervalSecond = sortedIntervals[j]
      
      if intervalFirst[1] > intervalSecond[0] {
        j += 1
        answer += 1
      } else {
        i = j
        j += 1
      }
    }
    return answer
  }
  
  /*
   Very Important: Question: Leetcode 621, Task Scheduler
   */
  func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
    var len = tasks.count
    var countArray = Array(repeating: 0, count: 26)
    var a: Character = "A"
    for char in tasks {
      var idx = Int(char.asciiValue! - a.asciiValue!)
      countArray[idx] += 1
    }
    var pq = PriorityQueueCustom<Node>()
    for i in 0 ..< 26 {
      if countArray[i] > 0 {
        var node = Node(i, countArray[i])
        pq.push(node)
      }
    }
    var array: [Node] = []
    var pointer = len
    var time = 0
    while pointer > 0 {
      var interval = n+1
      while !pq.isEmpty {
        var popped = pq.pop()!
        pointer -= 1
        interval -= 1
        time += 1
        popped.count -= 1
        array.append(popped)
        if interval == 0 {
          break
        }
      }
      if pointer > 0 { //Only add time if tasks are still remaining.
        time += interval
      }
      for node in array {
        if node.count > 0 {
          pq.push(node)
        }
      }
      array = []
    }
    return time
  }
  
  class Node: Comparable {
    var char: Int
    var count: Int
    
    init(_ char: Int, _ count: Int) {
      self.char = char
      self.count = count
    }
    
    static func < (lhs: Node, rhs: Node) -> Bool {
      return lhs.count > rhs.count // Max-heap on priority
    }
    
    static func == (lhs: Node, rhs: Node) -> Bool {
      return lhs.char == rhs.char && lhs.count == rhs.count
    }
  }
  
  /*
   Question: Leetcode 134, Gas Station
   Approach: Calculate anticlockwise the maximum gas that can be collected if we start from each station.
   */
  func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
    var gasTotal = gas.reduce(0) { $0 + $1 }
    var totalCost = cost.reduce(0) { $0 + $1 }
    
    if totalCost > gasTotal {
      return -1
    }
    var count = gas.count
    var maxGas = 0
    var totalGas = 0
    var maxIndex = -1
    for i in (0 ..< count).reversed() {
      var gasAtI = gas[i]
      var costAtI = cost[i]
      
      totalGas += (gasAtI - costAtI)
      if totalGas >= maxGas {
        maxGas = totalGas
        maxIndex = i
      }
    }
    return maxIndex
  }
  
  /*
   Question: Leetcode 452, Minimum Number of Arrows to Burst Balloons
   Approach: Simple merge interval problem
   Rememer: while merging intervals, always sort on basis of end time of intervals.
   */
  func findMinArrowShots(_ points: [[Int]]) -> Int {
    var sortedArray = points.sorted {
      if $0[1] == $1[1] {
        return $0[0] < $1[0]
      }
      return $0[1] < $1[1]
    }
    
    var answer = 0
    var count = points.count
    if count == 0 || count == 1{
      return count
    }
    var back = 0
    var forward = 1
    answer += 1
    while forward < count {
      if sortedArray[back][1] < sortedArray[forward][0] {
        answer += 1
        back = forward
      }
      forward += 1
    }
    return answer
  }
  
  /*
   Question: leetcode 122 Best Time to Buy and Sell Stock II
    When next element is smaller, make a sell and update buy price and sell price.
    When next element is greater, update the sell price.
    At last if sell price > buy price, make a sell and return answer
   */
  func maxProfit(_ prices: [Int]) -> Int {
    var buyPrice = prices[0]
    var sellPrice = prices[0]
    var answer = 0
    for i in 1 ..< prices.count {
      var ele = prices[i]
      if ele < sellPrice {
        answer += sellPrice - buyPrice
        buyPrice = ele
        sellPrice = ele
      } else {
        sellPrice = ele
      }
    }
    
    if sellPrice >= buyPrice {
      answer += sellPrice - buyPrice
    }
    return answer
  }
  
  /*
   Question: Leetcode 763 Partition Labels
   */
  func partitionLabels(_ s: String) -> [Int] {
    var countArray = Array(repeating: 0, count: 26)
    for char in s {
      var index = Int(char.asciiValue! - Character("a").asciiValue!)
      countArray[index] += 1
    }
    
    var answer: [Int] = []
    var length = 0
    var hasSet = Set<Int>()
    for char in s {
      var idx = Int(char.asciiValue! - Character("a").asciiValue!)
      countArray[idx] -= 1
      hasSet.insert(idx)
      length += 1
      var size = hasSet.count
      var count = 0
      for idx in hasSet {
        if countArray[idx] == 0 {
          count += 1
        }
      }
      if count == size {
        answer.append(length)
        length = 0
        hasSet.removeAll()
      }
    }
    
    return answer
  }
  
  /*
   Question: Leetcode 871 Minimum Number of Refueling Stops
   Very important question.
   */
  func minRefuelStops(_ target: Int, _ startFuel: Int, _ stations: [[Int]]) -> Int {
    var pq = PriorityQueueCustom<Int>() // max-heap of fuel values
    var pointer = 0
    var dist = startFuel
    var answer = 0
    let n = stations.count
    
    while dist < target {
      // Push all stations within reach into the heap
      while pointer < n && stations[pointer][0] <= dist {
        pq.push(stations[pointer][1]) // just push the fuel
        pointer += 1
      }
      
      // No stations we can use → stuck
      if pq.isEmpty {
        return -1
      }
      
      // Refuel from the best (highest fuel) station
      dist += pq.pop()!
      answer += 1
    }
    
    return answer
  }
}
