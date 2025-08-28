//
//  DP_level_1.swift
//  DSA
//
//  Created by Rahul Sureka on 05/08/25.
//

import Foundation
class DP_level_1 {
  // Dynamic Programming - Easy Level Problems
  
  
  //Question 1: Fibonacci Sequence
  func fibonacciSequenceUsingRecursion(n: Int) -> Int {
    if n == 0 || n == 1 {
      return n
    }
    return fibonacciSequenceUsingRecursion(n: n - 1) + fibonacciSequenceUsingRecursion(n: n - 2)
  }
  //Problem in the above code
  /*
   the fib(n) = fib(n-1) + fib(n-2)
   this fib(n-1) calls fib(n-2) and fib(n-3) again and although we already have fib(n-2) calculated, we are calculating it again.
   like wise we are calculating fib(n-3) again and so on.
   
   Solution:
   Can't we store the values in a dictionary or array and use them when needed?
   // Yes, we can use memoization or tabulation to store the values and use them when needed.
   */
  
  //Using Memozization
  func fibonacciSequenceUsingMemoization(n: Int) -> Int {
    var dp = Array(repeating: -1, count: n + 1)
    fillDP(&dp, n)
    return dp[n]
  }
  private func fillDP(_ dp: inout [Int], _ n: Int) {
    if n == 0 || n == 1 {
      dp[n] = n
      return
    }
    fillDP(&dp, n-1)
    return dp[n] = dp[n-1] + dp[n-2]
  }
  
  //Using Tabulation
  func fibonacciSequenceUsingTabulation(n: Int) -> Int {
    var dp = Array(repeating: 0, count: n + 1)
    for i in 0 ... n {
      if i == 0 || i == 1 {
        dp[i] = i
      } else {
        dp[i] = dp[i - 1] + dp[i - 2]
      }
    }
    return dp[n]
  }
  //fibonacciSequenceUsingRecursion(n: 10)
  //fibonacciSequenceUsingTabulation(n: 8)
  
  //-------------------------------------------------------------------------------
  /*
   Question 2: Climbing down stairs
   Desc: you are climing down a staircase with n steps. You can either take 1 step, 2 steps or 3 at a time. How many distinct ways can you climb down the stairs?
   */
  func climbingDownStairsUsingMemozation(n: Int) -> Int {
    var dp = Array(repeating: -1, count: n + 1)
    fillDPForClimbingDownStairs(&dp, n)
    return dp[n]
  }
  private func fillDPForClimbingDownStairs(_ dp: inout [Int], _ n: Int) {
    if n == 0 {
      dp[0] = 1
      return
    }
    fillDPForClimbingDownStairs(&dp, n-1)
    dp[n] = (n >= 1 ? dp[n-1] : 0) + (n >= 2 ? dp[n-2] : 0) + (n >= 3 ? dp[n-3] : 0)
  }
  
  func climbingDownStairsUsingTabulation(n: Int) -> Int {
    var dp = Array(repeating: 0, count: n + 1)
    dp[0] = 1 // Base case: 1 way to go from ground to ground
    for i in 1 ... n {
      if i == 1 {
        dp[i] = dp[i-1] // Only one way to go from 1 to ground
      } else if i == 2 {
        dp[i] = dp[i-1] + dp[i-2] // Two ways to go from 2 to ground
      } else if i == 3 {
        dp[i] = dp[i-1] + dp[i-2] + dp[i-3] // Three ways to go from 3 to ground
      } else {
        dp[i] = dp[i-1] + dp[i-2] + dp[i-3] // For n > 3, sum of the last three steps
      }
    }
    return dp[n]
  }
  //climbingDownStairsUsingMemozation(n: 10)
  //climbingDownStairsUsingTabulation(n: 10)
  //-------------------------------------------------------------------------------
  /*
   Question 3: Minimum Cost Path
   Desc: Given a 2D grid of costs, find the minimum cost to reach from the top-left corner to the bottom-right corner. You can only move right or down.
   */
  func minCostPathUsingMemoization(grid: [[Int]]) -> Int {
    let rows = grid.count
    let cols = grid[0].count
    
    var dp = Array(repeating: Array(repeating: -1, count: cols), count: rows)
    return findMinCostPath(&dp, grid, rows - 1, cols - 1)
  }
  private func findMinCostPath(_ dp: inout [[Int]], _ grid: [[Int]], _ row: Int, _ col: Int) -> Int {
    if dp[row][col] != -1 {
      return dp[row][col]
    }
    if row == 0 && col == 0 {
      dp[row][col] = grid[row][col]
      return dp[row][col]
    }
    if row > 0 && col > 0 {
      dp[row][col] = min(findMinCostPath(&dp, grid, row - 1, col) + grid[row][col],
                         findMinCostPath(&dp, grid, row, col - 1) + grid[row][col])
    } else if row > 0 {
      dp[row][col] = findMinCostPath(&dp, grid, row - 1, col) + grid[row][col]
    } else {
      dp[row][col] = findMinCostPath(&dp, grid, row, col - 1) + grid[row][col]
    }
    return dp[row][col]
  }
  
  func minCostPathUsingTabulation(grid: [[Int]]) -> Int {
    let rows = grid.count
    let cols = grid[0].count
    
    var dp = Array(repeating: Array(repeating: 0, count: cols), count: rows)
    for i in 0..<rows {
      for j in 0..<cols {
        if i == 0 && j == 0 {
          dp[i][j] = grid[i][j] // Starting point
        } else if (i == 0) {
          dp[i][j] = dp[i][j - 1] + grid[i][j] // Can only come from left
        } else if (j == 0) {
          dp[i][j] = dp[i - 1][j] + grid[i][j] // Can only come from above
        } else {
          dp[i][j] = min(dp[i - 1][j], dp[i][j - 1]) + grid[i][j] // Take the minimum from left or above
        }
      }
    }
    return dp[rows - 1][cols - 1] // Return the minimum cost to reach the bottom-right corner
  }
  
  var grid = [
    [1, 3, 1],
    [1, 5, 4],
    [4, 2, 1]
  ]
  //minCostPathUsingMemoization(grid: grid)
  //minCostPathUsingTabulation(grid: grid)
  
  // -------------------------------------------------------------------------------
  //New group of DP questions - Target Sum subsets - Most IMP
  /*
   Question 1: Subset sum problem
   desc: Given a set of non-negative integers, determine if there is a subset that sums up to a given target.
   
   Solution: Cosider it as a cricket match problem, where you can either choose to play a shot or not. Lets say, the x players has to score 50 runs combined with all previous players. The xth player can only score 11 runs, the possiblities are:
   1. xth player scores 11 runs, then the previous players have to score 39 runs.
   2. xth player does not score, then the previous players have to score 50 runs.
   
   This way we can break the problem into smaller subproblems.
   */
  
  func subsetSumUsingMemoization(nums: [Int], target: Int) -> Bool {
    var length = nums.count
    var dp = Array(repeating: Array(repeating: false, count: target+1), count: length)
    return calculateSubsetSum(&dp, nums, length - 1, target)
  }
  
  private func calculateSubsetSum(_ dp: inout [[Bool]], _ nums: [Int], _ index: Int, _ target: Int) -> Bool {
    if target == 0 {
      dp[index][target] = true
    } else if index == 0 {
      if nums[index] == target {
        dp[index][target] = true
      } else {
        dp[index][target] = false
      }
    } else {
      if target >= nums[index] {
        dp[index][target] = calculateSubsetSum(&dp, nums, index-1, target) ||
        calculateSubsetSum(&dp, nums, index-1, target-nums[index])
      } else {
        dp[index][target] = calculateSubsetSum(&dp, nums, index-1, target)
      }
    }
    return dp[index][target]
  }
  
  func subsetSumUsingTabulation(nums: [Int], target: Int) -> Bool {
    let length = nums.count
    var dp = Array(repeating: Array(repeating: false, count: target + 1), count: length)
    
    for i in 0 ..< length {
      for j in 0 ... target {
        if j == 0 {
          dp[i][j] = true
        } else if i == 0 {
          if nums[i] == target {
            dp[i][j] = true
          } else {
            dp[i][j] = false
          }
        } else {
          if j >= nums[i] {
            dp[i][j] = dp[i-1][j] || dp[i-1][j-nums[i]]
          } else {
            dp[i][j] = dp[i-1][j]
          }
        }
      }
    }
    return dp[length-1][target]
  }
  
  var num = [3, 34, 4, 12, 2, 3]
  //subsetSumUsingMemoization(nums: num, target: 9)
  //subsetSumUsingTabulation(nums: num, target: 9)
  
  //-------------------------------------------------------------------------------
  /*
   Question 2: Coin change permutation
   Desc: Given a set of coins with infinite supply and a target amount, find the number of ways (permutation) to make the target amount using the coins.
   solution: The problem can be solved, by traversing from 0 to target like we travel from 0 to target and calculate the number of ways to reach each amount using coins.
   ex: let say we have 1, 2, 5 coins and we want to calculate for 15. We will sum the ways to reach 14, 13 and 10
   */
  
  func coinChangePermutationUsingMemoization(coins: [Int], target: Int) -> Int {
    var dp = Array(repeating: -1, count: target + 1)
    return calculateCoinChangePermutation(&dp, coins, target)
  }
  
  private func calculateCoinChangePermutation(_ dp: inout [Int], _ coins: [Int], _ target: Int) -> Int {
    if dp[target] != -1 {
      return dp[target]
    }
    if target == 0 {
      dp[target] = 1
    } else {
      var sum = 0
      for coin in coins {
        if target - coin >= 0 {
          sum += calculateCoinChangePermutation(&dp, coins, target - coin)
        }
      }
      dp[target] = sum
    }
    
    return dp[target]
  }
  
  func coinChangePermutationUsingTabulation(coins: [Int], target: Int) -> Int {
    var dp = Array(repeating: 0, count: target + 1)
    for i in 0 ... target {
      if i == 0 {
        dp[i] = 1 // Base case: 1 way to make 0 amount
      }
      for coin in coins {
        if i >= coin {
          dp[i] += dp[i - coin] // Add the number of ways to make (i - coin)
        }
      }
    }
    return dp[target]
  }
  var nums = [1, 2, 5]
  //coinChangePermutationUsingMemoization(coins: nums, target: 5)
  //coinChangePermutationUsingTabulation(coins: nums, target: 5)
  
  
  
  /*
   Question 3: Coin change combination
   Desc: Given a set of coins with infinite supply and a target amount, find the number of ways (combination) to make the target amount using the coins.
   Solution: The problem can be solved, by traversing from 0 to target like we travel from 0 to target and calculate the number of ways to reach each amount using coins. Remember it is combination, so we will not consider the order of coins.
   */
  
  func coinChangeCombinationUsingTabulation(coins: [Int], target: Int) -> Int {
    var dp = Array(repeating: 0, count: target + 1)
    for coin in coins {
      for i in 0 ... target {
        if i == 0 {
          dp[i] = 1
        } else {
          if i >= coin {
            dp[i] += dp[i - coin]
          }
        }
      }
    }
    return dp[target]
  }
  
  func coinChangeCombinationUsingMemoization(coins: [Int], target: Int) -> Int {
    var dp = Array(
      repeating: Array(repeating: -1, count: target + 1),
      count: coins.count + 1
    )
    return calculateCoinChangeCombination(&dp, coins, 0, target)
  }
  
  private func calculateCoinChangeCombination(_ dp: inout [[Int]], _ coins: [Int], _ index: Int, _ target: Int) -> Int {
    if target == 0 { return 1 }
    if target < 0 || index == coins.count { return 0 }
    if dp[index][target] != -1 { return dp[index][target] }
    
    // Include current coin
    let include = calculateCoinChangeCombination(&dp, coins, index, target - coins[index])
    // Exclude current coin
    let exclude = calculateCoinChangeCombination(&dp, coins, index + 1, target)
    
    dp[index][target] = include + exclude
    return dp[index][target]
  }
  
  //coinChangeCombinationUsingTabulation(coins: nums, target: 5)
  //coinChangeCombinationUsingMemoization(coins: nums, target: 5)
  
  //-------------------------------------------------------------------------------
  /*
   Question 4: 0-1 Knapsack problem
   Desc: Given a set of items, each with a weight and value, determine the maximum value that can be obtained by selecting items such that their total weight does not exceed a given capacity.
   */
  func knapsackUsingTabulation(items: [(weight: Int, value: Int)], capacity: Int) -> Int {
    let n = items.count
    var dp = Array(repeating: Array(repeating: -1, count: capacity + 1), count: n)
    
    for i in 0 ..< n {
      for j in 0 ... capacity {
        if j == 0 {
          dp[i][j] = 0
        } else {
          //exclude
          var exclude = i > 0 ? dp[i - 1][j] : 0
          var include = j >= items[i].weight ? items[i].value + (i > 0 ? dp[i-1][j-items[i].weight] : 0) : 0
          
          dp[i][j] = max(include, exclude)
        }
      }
    }
    return dp[n - 1][capacity]
  }
  
  func knapsackleUsingMemoization(items: [(weight: Int, value: Int)], capacity: Int) -> Int {
    let n = items.count
    var dp = Array(repeating: Array(repeating: -1, count: capacity + 1), count: n)
    
    return calculateKnapsack(&dp, items, n - 1, capacity)
  }
  
  private func calculateKnapsack(_ dp: inout [[Int]], _ items: [(weight: Int, value: Int)], _ index: Int, _ capacity: Int) -> Int {
    if dp[index][capacity] != -1 {
      return dp[index][capacity]
    }
    if capacity == 0 {
      dp[index][capacity] = 0
      return dp[index][capacity]
    }
    
    //include
    var include = capacity >= items[index].weight ? items[index].value + (index > 0 ? calculateKnapsack(&dp, items, index - 1, capacity - items[index].weight) : 0) : 0
    //exclude
    var exclude = index > 0 ? calculateKnapsack(&dp, items, index - 1, capacity) : 0
    
    dp[index][capacity] = max(include, exclude)
    return dp[index][capacity]
  }
  
  var items = [(weight: 1, value: 1), (weight: 3, value: 4), (weight: 4, value: 6)]
  //knapsackUsingTabulation(items: items, capacity: 5)
  //knapsackleUsingMemoization(items: items, capacity: 5)
  
  //-------------------------------------------------------------------------------
  /*
   Question 5: Unbounded Knapsack problem
   Desc: Given a set of items, each with a weight and value, determine the maximum value that can be obtained by selecting items such that their total weight does not exceed a given capacity. Each item can be selected multiple times.
   */
  func unboundedKnapsackUsingTabulation(items: [(weight: Int, value: Int)], capacity: Int) -> Int {
    var n = items.count
    var dp = Array(repeating: 0, count: capacity + 1)
    
    for i in 0 ... capacity {
      if i == 0 {
        dp[i] = 0 // Base case: 0 capacity means 0 value
        continue
      }
      for j in 0 ..< n {
        if i >= items[j].weight {
          dp[i] = max(dp[i], dp[i-items[j].weight] + items[j].value)
        }
      }
    }
    
    return dp[capacity]
  }
  items = [(weight: 2, value: 3), (weight: 3, value: 4), (weight: 4, value: 5)]
  let capacity = 6
  //unboundedKnapsackUsingTabulation(items: items, capacity: capacity)
  
  
  func unboundedKnapsackUsingMemoization(items: [(weight: Int, value: Int)], capacity: Int) -> Int {
    var n = items.count
    var dp = Array(repeating: Array(repeating: -1, count: capacity + 1), count: n)
    
    return calculateUnboundedKnapsack(&dp, items, capacity, 0)
  }
  
  private func calculateUnboundedKnapsack(_ dp: inout [[Int]], _ items: [(weight: Int, value: Int)], _ capacity: Int, _ index: Int) -> Int {
    if index >= items.count { return 0 }
    if capacity == 0 { return 0 }
    if dp[index][capacity] != -1 { return dp[index][capacity] }
    
    // Exclude current item
    let exclude = calculateUnboundedKnapsack(&dp, items, capacity, index + 1)
    // Include current item (can take again)
    var include = 0
    if capacity >= items[index].weight {
      include = items[index].value + calculateUnboundedKnapsack(&dp, items, capacity - items[index].weight, index)
    }
    dp[index][capacity] = max(include, exclude)
    return dp[index][capacity]
  }
  //unboundedKnapsackUsingMemoization(items: items, capacity: 6)
  //-------------------------------------------------------------------------------
  
  /*
   New Group of DP question: Include exclude principle
   Question 1: Count bunary strings with no consecutive 0's
   Desc: Given a binary string of length n, count the number of binary strings with no consecutive 0's.
   Solution: The problem can be solved by considering the last character of the string. If the last character is 1, then the previous character can be either 0 or 1. If the last character is 0, then the previous character must be 1.
   DP: 2*N dp where N is the length of the string. We store the number of strings ending with 0 and 1 separately.
   */
  
  func countBinaryStringsNoConsecutiveZerosTabulation(n: Int) -> Int {
    if n == 0 {
      return 0
    }
    var dp = Array(repeating: Array(repeating: 0, count: n), count: 2)
    for i in 0 ..< n {
      if i == 0 {
        dp[0][i] = 1 // Base case: "0"
        dp[1][i] = 1 // Base case: "1"
      } else {
        dp[0][i] = dp[1][i-1]
        dp[1][i] = dp[0][i-1] + dp[1][i-1]
      }
    }
    return dp[0][n-1] + dp[1][n-1] // Total number of valid binary strings of length n
  }
  //countBinaryStringsNoConsecutiveZerosTabulation(n: 3)
  
  func countBinaryStringsNoConsecutiveZerosMemoization(n: Int) -> Int {
    var dp = Array(repeating: Array(repeating: -1, count: n), count: 2)
    return calculateBinaryStrings(&dp, n-1, 0) + calculateBinaryStrings(&dp, n-1, 1)
  }
  
  private func calculateBinaryStrings(_ dp: inout [[Int]], _ n: Int, _ char: Int) -> Int {
    if n == 0 {
      dp[char][n] = 1
      return 1
    }
    if dp[char][n] != -1 {
      return dp[char][n]
    }
    var count_1 = calculateBinaryStrings(&dp, n - 1, 1) // If last character is 1
    var count_0 = calculateBinaryStrings(&dp, n-1, 0) // If last character is 0
    
    if char == 0 {
      dp[char][n] = count_1 // If last character is 0, previous must be 1
    } else {
      dp[char][n] = count_0 + count_1 // If last character is 1, previous can be 0 or 1
    }
    
    return dp[char][n]
  }
  countBinaryStringsNoConsecutiveZerosMemoization(n: 3)
  
  //-------------------------------------------------------------------------------
  /*
   Question 2: Count Subsequences of form A^i B^j C^k
   Desc: Given a string containing only characters 'A', 'B', and 'C', count the number of subsequences of the form A^i B^j C^k where i, j, k > 0.
   Solution: The problem can be solved by using dynamic programming. We can maintain three counts for 'A', 'B', and 'C' and update them as we traverse the string.
   Solution video https://youtu.be/IV9pbZsi5cc?si=9qd52iVmETeUrSsD
   next A: 2*prev_A + 1
   next B: 2*prev_B + prev_A
   next C: 2*prev_C + prev_B
   |        |  0  |  1 (a)           |  2 (b)                |  3 (c)                |  4 (a)                |  5 (b)                |  6 (c)                |
   |--------|-----|------------------|-----------------------|-----------------------|-----------------------|-----------------------|-----------------------|
   | aCount |  0  | 1 = 2*0+1        | 1 = 1                 | 1 = 1                 | 3 = 2*1+1             | 3 = 3                 | 3 = 3                 |
   | bCount |  0  | 0                | 1 = 2*0+1             | 1 = 1                 | 1 = 1                 | 5 = 2*1+3             | 5 = 5                 |
   | cCount |  0  | 0                | 0                     | 1 = 2*0+1             | 1 = 1                 | 1 = 1                 | 11 = 2*1+5            |
   */
  
  func countSubsequencesUsingTabulation(s: String) -> Int {
    var aCount = 0, bCount = 0, cCount = 0
    for ch in s {
      if ch == "a" {
        aCount = 2 * aCount + 1
      } else if ch == "b" {
        bCount = 2 * bCount + aCount
      } else if ch == "c" {
        cCount = 2 * cCount + bCount
      }
    }
    return cCount
  }
  
  /*
   Question: Leetcode: 688 - Knight Tour Problem.
   */
  private let directions = [
    (2, 1), (2, -1), (-2, 1), (-2, -1),
    (1, 2), (1, -2), (-1, 2), (-1, -2)
  ]
  
  func knightProbability(_ n: Int, _ k: Int, _ row: Int, _ column: Int) -> Double {
    if k == 0 { return 1.0 }
    // Initialize a 3D DP array with 0.0
    var dp = Array(repeating: Array(repeating: Array(repeating: 0.0, count: n), count: n), count: k + 1)
    
    // Base case: At step 0, the knight is at (row, column)
    dp[0][row][column] = 1.0
    
    // DP transition
    for step in 1...k {
      for r in 0..<n {
        for c in 0..<n {
          if dp[step - 1][r][c] > 0 {
            for direction in directions {
              let nr = r + direction.0
              let nc = c + direction.1
              if nr >= 0 && nr < n && nc >= 0 && nc < n {
                dp[step][nr][nc] += dp[step - 1][r][c] / 8.0
              }
            }
          }
        }
      }
    }
    
    // Sum up probabilities for all positions on the board after k moves
    var result = 0.0
    for r in 0..<n {
      for c in 0..<n {
        result += dp[k][r][c]
      }
    }
    
    return result
  }
  
  /*
   Leetcode 673: Number of Longest Increasing Subsequence
   Very important question
   Approach: Maintain 2 DP one for longest increasing subsequence length ending at i, and another for number of longest increasing subsequence ending at i.
   */
  func findNumberOfLIS(_ nums: [Int]) -> Int {
    var len = nums.count
    var dp = Array(repeating: 0, count: len)
    var dpCount = Array(repeating: 0, count: len)
    var maxVal = 0
    for i in 0 ..< len {
      var num = nums[i]
      var maxLen = 0
      var count = 0
      for j in 0 ..< i {
        var numPrev = nums[j]
        
        if numPrev < num {
          if dp[j] > maxLen {
            maxLen = dp[j]
            count = dpCount[j]
          } else if dp[j] == maxLen {
            count += dpCount[j]
          }
        }
      }
      
      count = max(count, 1)
      maxLen = maxLen + 1
      dp[i] = maxLen
      dpCount[i] = count
      maxVal = max(maxVal, dp[i])
    }
    var maxCount = 0
    for i in 0 ..< len {
      if dp[i] == maxVal {
        maxCount += dpCount[i]
      }
    }
    
    return maxCount
  }
  
  /*
   Leetcode 1143: Longest common subsequence
   Approach
   a b c d e
   a   1 1 1 1 1
   c   1 1 2 2 2
   e   1 1 2 2 3
   
   Based on Dp above: we have a formula
   DP[i][j] = arr1[i] == arr2[j] ? max(dp[i-1],dp[j-1] + 1, dp[i-1][j], dp[i][j-1]) : max(dp[i-1][j], dp[i][j-1])
   */
  func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
    var dp = Array(repeating: Array(repeating: 0, count: text2.count), count: text1.count)
    var textArr1 = Array(text1)
    var textArr2 = Array(text2)
    
    for i in 0 ..< text1.count {
      for j in 0 ..< text2.count {
        var charA = textArr1[i]
        var charB = textArr2[j]
        if i == 0 && j == 0 {
          if charA == charB {
            dp[i][j] = 1
          } else {
            dp[i][j] = 0
          }
        } else if i == 0 {
          if charA == charB {
            dp[i][j] = 1
          } else {
            dp[i][j] = dp[i][j-1]
          }
        } else if j == 0 {
          if charA == charB {
            dp[i][j] = 1
          } else {
            dp[i][j] = dp[i-1][j]
          }
        } else {
          if charA == charB {
            dp[i][j] = max(dp[i-1][j-1] + 1, max(dp[i-1][j], dp[i][j-1]))
          } else {
            dp[i][j] = max(dp[i-1][j], dp[i][j-1])
          }
        }
      }
    }
    
    return dp[text1.count - 1][text2.count - 1]
  }
  
  /*
   Leetcode 72: Edit distance
   Here: Replace: [i-1][j-1],
   delete: [i][j-1]
   insert: [i-1][j]
   ""  h o r s e
   "" 0  1 2 3 4 5
   r  1  1 2 2 3 4
   o  2  2 1 2 3 4
   s  3  3 2 2 2 3
   */
  func minDistance(_ w1: String, _ w2: String) -> Int {
    var len1 = w1.count
    var len2 = w2.count
    
    var arrW1 = Array(w1)
    var arrW2 = Array(w2)
    var dp = Array(repeating: Array(repeating: 0, count: len2 + 1), count: len1 + 1)
    
    for i in 0 ... len1 {
      for j in 0 ... len2 {
        if i == 0 && j == 0 {
          dp[i][j] = 0
        } else if i == 0 {
          dp[i][j] = dp[i][j-1] + 1
        } else if j == 0 {
          dp[i][j] = dp[i-1][j] + 1
        } else {
          var charA = arrW1[i-1]
          var charB = arrW2[j-1]
          
          if charA == charB {
            dp[i][j] = min(dp[i-1][j-1], min(dp[i-1][j], dp[i][j-1]) + 1)
          } else {
            dp[i][j] = min(dp[i-1][j-1], min(dp[i-1][j], dp[i][j-1])) + 1
          }
        }
      }
    }
    // print(dp)
    return dp[len1][len2]
  }
  
  /*
   Leetcode 97: Interleaving String
   Approach:
   For 2 strings s1 and s2, and a string s3
   if s1[i] == s3[i+j] then we take from s1 and incremente i += 1
   if s2[j] == s3[i+j] then we take from s2 and increment j += 1
   
   If both s1[i] == s3[i+j] && s2[j] == s3[i+j] then we have to explore both paths.
   We cannot use else as we need to explore both paths.
   */
  func isInterleave(_ s1: String, _ s2: String, _ s3: String) -> Bool {
    var lenS1 = s1.count
    var lenS2 = s2.count
    var len = s3.count
    
    if lenS1 + lenS2 != len {
      return false
    }
    
    var array1 = Array(s1)
    var array2 = Array(s2)
    var array3 = Array(s3)
    var dp: [[Bool?]] = Array(repeating: Array<Bool?>(repeating: nil, count: lenS2+1), count: lenS1+1)
    
    func recursion(_ i: Int, _ j: Int) -> Bool {
      if i == lenS1 && j == lenS2 {
        return true
      }
      
      if dp[i][j] != nil {
        return dp[i][j]!
      }
      
      if i < lenS1 && array1[i] == array3[i+j] {
        var ans = recursion(i+1, j)
        if ans  {
          dp[i][j] = true
          return true
        }
      }
      
      if j < lenS2 && array2[j] == array3[i+j] {
        var ans = recursion(i, j+1)
        if ans  {
          dp[i][j] = true
          return true
        }
      }
      dp[i][j] = false
      return false
      
    }
    
    var ans = recursion(0, 0)
    return ans
  }
  
  /*
   Leetcode 115: Distinct Subsequences  (Hard)
   Approach:
   Make a db on s.length+1 * t.length+1.
   Meaning: for each cell, the meaning is "how many distinct subsequence we can make out of s[0 ... i] into t[0 ... j"
   
   Sample DP
   here, we cannot make subsequece if s.length < t.length. So lower half will be 0
   And, tp make an empty subsequence from any string only 1 way that i.e. don't include anything.
   dp[i][j] = if s[i] == t[j] ? dp[i-1][j-1] + dp[i][j-1] : dp[i][j-1]
   0   r   a   b   b   b   i   t
   0   1   1   1   1   1   1   1   1
   r
   a
   b
   b
   i
   t
   
   Key note: we can use &+ to allow overflow in case of large numbers.
   */
  func numDistinct(_ s: String, _ t: String) -> Int {
    var len1 = s.count
    var len2 = t.count
    var arrS = Array(s)
    var arrT = Array(t)
    
    var dp = Array(repeating: Array(repeating: 0, count: len1 + 1), count: len2 + 1)
    for i in 0 ... len2 {
      for j in 0 ... len1 {
        if i == 0 && j == 0 {
          dp[i][j] = 1
        } else if i == 0 {
          dp[i][j] = 1
        } else if j == 0 {
          dp[i][j] = 0
        } else {
          var charS = arrS[j-1]
          var charT = arrT[i-1]
          
          dp[i][j] = charS == charT ? dp[i-1][j-1] &+ dp[i][j-1] : dp[i][j-1]
        }
      }
    }
    
    return dp[len2][len1]
  }
  
  /*
   Leetcode 139: Word Break
   Approach:
   we make a dp of length as s.count + 1
   let say s = leetcode
   dp: empty word will be always be in dict (assumed)
   0 l e e t c o d e
   t f f f t f f f t
   */
  func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
    let n = s.count
    let wordSet = Set(wordDict)
    var dp = [Bool](repeating: false, count: n + 1)
    dp[0] = true   // empty string can always be segmented
    
    let chars = Array(s)   // convert once, gives O(1) indexing
    
    for i in 1...n {
      for j in 0..<i {
        if dp[j] {
          let word = String(chars[j..<i])   // substring s[j..<i]
          if wordSet.contains(word) {
            dp[i] = true
            break   // no need to check smaller j
          }
        }
      }
    }
    return dp[n]
  }
  
  /*
   Leetcode 140: Word Break II
   */
  func wordBreak(_ s: String, _ wordDict: [String]) -> [String] {
    var len = s.count
    var dp = Array(repeating: [String](), count: len)
    var wordSet = Set(wordDict)
    var array = Array(s)
    
    for i in 0..<len {
      // Case: full prefix is a word
      let fullPrefix = String(array[0...i])
      if wordSet.contains(fullPrefix) {
        dp[i].append(fullPrefix)
      }
      
      // Check all earlier breaks
      for j in 0..<i {
        if dp[j].isEmpty { continue }
        
        let sub = String(array[(j+1)...i])
        if wordSet.contains(sub) {
          for sentence in dp[j] {
            dp[i].append(sentence + " " + sub)
          }
        }
      }
    }
    return dp[len - 1]
  }
  
  /*
   Leetcode 10: Regular Expression Matching
   Very important question
   */
  func isMatch(_ s: String, _ p: String) -> Bool {
    let sArr = Array(s)
    let pArr = Array(p)
    let m = sArr.count
    let n = pArr.count
    
    // dp[i][j] = does s[0..<i] match p[0..<j]
    var dp = Array(repeating: Array(repeating: false, count: n + 1), count: m + 1)
    dp[0][0] = true  // empty string matches empty pattern
    
    // Fill first row: matches between empty s and pattern p
    for j in 1...n {
      if pArr[j - 1] == "*" && j >= 2 {
        dp[0][j] = dp[0][j - 2]
      }
    }
    
    for i in 1...m {
      for j in 1...n {
        if pArr[j - 1] == "." || pArr[j - 1] == sArr[i - 1] {
          // direct match or '.' wildcard
          dp[i][j] = dp[i - 1][j - 1]
        } else if pArr[j - 1] == "*" {
          // two cases:
          // 1. Treat '*' as 0 occurrences: dp[i][j-2]
          dp[i][j] = dp[i][j - 2]
          
          // 2. Treat '*' as 1+ occurrences if preceding char matches
          let prevChar = pArr[j - 2]
          if prevChar == "." || prevChar == sArr[i - 1] {
            dp[i][j] = dp[i][j] || dp[i - 1][j]
          }
        }
      }
    }
    
    return dp[m][n]
  }
  
  /*
   Leetcode 44: Wildcard Matching
   let words be s: misissipi, p: m*s?*, yes
   0 m * s ? p *
   0   1 0 0 0 0 0 0
   m   0 1 1 0 0 0 0
   i   0 0 1 0 0 0 0
   s   0 0 1
   i   0
   s   0
   s   0
   i   0
   p   0
   i   0
   got the formula
   for char: if != false, if == i-1, j-1
   for ?: i-1,j-1
   for *: i,j-1 || i-1,j
   */
  func isMatch(_ s: String, _ p: String) -> Bool {
    var lenS = s.count
    var lenP = p.count
    var arrS = Array(s)
    var arrP = Array(p)
    var dp = Array(repeating: Array(repeating: false, count: lenP + 1), count: lenS + 1)
    
    //Base case
    dp[0][0] = true
    if lenS == 0 && lenP == 0 {
      return true
    }
    if lenP == 0 {
      return false
    }
    //Fill top row
    for j in 1 ... lenP {
      dp[0][j] = arrP[j-1] == "*" ? dp[0][j-1] : false
    }
    if lenS == 0 {
      return dp[0][lenP]
    }
    for i in 1 ... lenS {
      for j in 1 ... lenP {
        var charP = arrP[j-1]
        var charS = arrS[i-1]
        
        if charP == "?" || charS == charP {
          dp[i][j] = dp[i-1][j-1]
        } else if charP == "*" {
          //When empty sequence
          dp[i][j] = dp[i][j-1]
          //When 1 or more sequence
          dp[i][j] = dp[i][j] || dp[i-1][j]
        }
      }
    }
    
    return dp[lenS][lenP]
  }
  
  /*
   Leetcode 416: Partition Equal Subset Sum
   Classic target sum subset.
   for every element we have 2 ops inluce/exclude.
   1st: Check if the sum is even, if odd return false
   2nd: make half and apply target sum subset.
   */
  func canPartition(_ nums: [Int]) -> Bool {
    var len = nums.count
    var sum = 0
    for num in nums {
      sum += num
    }
    if sum % 2 != 0 {
      return false
    }
    var target = sum/2
    var dp = Array(repeating: Array(repeating: false, count: target+1), count: len+1)
    //base case
    dp[0][0] = true
    for i in 1 ... len {
      dp[i][0] = true
    }
    
    for i in 1 ... len {
      for j in 1 ... target {
        var value = nums[i-1]
        
        //inlcude
        if j >= value {
          dp[i][j] = dp[i-1][j-value]
        }
        //exclude
        dp[i][j] = dp[i][j] || dp[i-1][j]
      }
    }
    
    return dp[len][target]
  }
  
  /*
   Leetcode 494: Target Sum
   Very important question
   */
  func findTargetSumWays(_ nums: [Int], _ target: Int) -> Int {
    var len = nums.count
    var sum = nums.reduce(0) {$0 + $1}
    var dp = Array(repeating: Array(repeating: -1, count: 2 * sum + 1), count: len)
    
    func memoization(_ idx: Int, _ target: Int, _ dp: inout [[Int]]) -> Int {
      if idx == len {
        return target == 0 ? 1 : 0
      }
      
      let offset = sum + target
      if offset < 0 || offset > 2 * sum {
        return 0
      }
      
      if dp[idx][sum + target] != -1 {
        return dp[idx][sum + target]
      }
      
      var num = nums[idx]
      //include
      var ans1 = memoization(idx + 1, target - num, &dp)
      
      //exclude
      var ans2 = memoization(idx + 1, target + num, &dp)
      
      dp[idx][sum + target] = ans1 + ans2
      return dp[idx][sum + target]
    }
    var ans = memoization(0, target, &dp)
    return ans
  }
  
  /*
   Leetcode 474: Ones and Zeros
   Imp question
   */
  func findMaxForm(_ strs: [String], _ m: Int, _ n: Int) -> Int {
    
    var dp = [State:Int]()
    var len = strs.count
    
    struct State: Hashable {
      let i: Int
      let m: Int
      let n: Int
    }
    
    func memoization(_ idx: Int, _ m: Int, _ n: Int, _ dp: inout [State:Int]) -> Int {
      if idx == len || m < 0 || n < 0{
        return 0
      }
      
      if let val = dp[State(i:idx, m:m, n:n)] {
        return val
      }
      
      var ones = strs[idx].filter { $0 == "1" }.count
      var zeros = strs[idx].filter { $0 == "0" }.count
      
      //include
      var include = 0
      if m - zeros >= 0 && n - ones >= 0 {
        include = memoization(idx + 1, m - zeros, n - ones, &dp) + 1
      }
      //exclude
      var exclude = memoization(idx + 1, m, n, &dp)
      
      var ans = max(include, exclude)
      dp[State(i:idx, m:m, n:n)] = ans
      return ans
    }
    
    var ans = memoization(0, m, n, &dp)
    return ans
  }
  
  /*
   Leetcode 221: Maximal Square
   formula: if arr[i][j] == 1 : min(arr[i-1][j-1], arr[i-1][j], arr[i][j-1]) + 1
   */
  
  func maximalSquare(_ matrix: [[Character]]) -> Int {
    var rows = matrix.count
    var cols = matrix[0].count
    
    if rows == 0 && cols == 0 {
      return 0
    }
    
    var table = Array(repeating: Array(repeating: 0, count: cols), count: rows)
    var maxSquare = 0
    for i in 0 ..< rows {
      if matrix[i][0] == "1" {
        table[i][0] = 1
        maxSquare = 1
      }
    }
    for j in 0 ..< cols {
      if matrix[0][j] == "1" {
        table[0][j] = 1
        maxSquare = 1
      }
    }
    for row in 1 ..< rows {
      for col in 1 ..< cols {
        if matrix[row][col] == "1" {
          table[row][col] = min(table[row-1][col-1], min(table[row][col-1], table[row-1][col])) + 1
          maxSquare = max(maxSquare, table[row][col])
        }
      }
    }
    return maxSquare * maxSquare
  }
  
  /*
   Leetcode 312: Burst Balloons
   Very important DP problem – interval DP using gap strategy
   
   Problem:
   You are given an array `nums` where each element represents a balloon with some coin value.
   When you burst a balloon `k`, you earn coins equal to:
   nums[i - 1] * nums[k] * nums[j + 1]
   where `i` and `j` are the adjacent balloons remaining after bursting `k`.
   
   Objective:
   Maximize the number of coins collected by bursting all balloons in an optimal order.
   
   Approach:
   
   1. Define a 2D DP table `dp[i][j]`:
   - dp[i][j] represents the maximum coins obtainable by bursting all balloons from index `i` to `j` (inclusive).
   - We need to decide the **last balloon** to burst in subarray `i...j`, because once it's the last, its adjacent values are fixed.
   
   2. Use gap strategy to fill `dp[i][j]`:
   - Outer loop: `gap` from 0 to n-1, representing window size.
   - Inner loop: for each window starting at `i`, compute `j = i + gap`.
   - Try all positions `k` from `i` to `j` as the last balloon to burst in that range.
   
   3. For each `k ∈ [i...j]`:
   - Compute:
   - `left = dp[i][k-1]` (if k > i) – coins from bursting balloons before `k`
   - `right = dp[k+1][j]` (if k < j) – coins from bursting balloons after `k`
   - `val = nums[i-1] * nums[k] * nums[j+1]`
   (boundary balloons are considered to be 1 if out of bounds)
   - Update:
   - `dp[i][j] = max(dp[i][j], left + right + val)`
   
   4. Final result:
   - After filling all gaps, the answer is stored in `dp[0][n-1]`, the full array range.
   
   Time Complexity:
   - O(n³) due to 3 nested loops (gap, i, k)
   Space Complexity:
   - O(n²) for the 2D dp table
   */
  
  func maxCoins(_ nums: [Int]) -> Int {
    let n = nums.count
    var dp = Array(repeating: Array(repeating: 0, count: n), count: n)
    
    for gap in 0..<n {
      for i in 0..<(len - gap - 1) {
        let j = i + gap
        var maxVal = 0
        for k in i...j {
          let left = (k == i) ? 0 : dp[i][k - 1]
          let right = (k == j) ? 0 : dp[k + 1][j]
          let val = (i == 0 ? 1 : nums[i - 1]) * nums[k] * (j == n - 1 ? 1 : nums[j + 1])
          
          maxVal = max(maxVal, left + right + val)
        }
        dp[i][j] = maxVal
      }
    }
    
    return dp[0][n - 1]
  }
  
  /*
   Leetcode 132: Palindrome Partitioning II
   
   Approach:
   
   This problem asks for the minimum number of cuts needed to partition a string
   such that every substring in the partition is a palindrome.
   
   We solve this using dynamic programming in two main steps:
   
   1. Precompute Palindromic Substrings (boolTable):
   - We create a 2D DP table `boolTable[i][j]` to store whether the substring s[i...j] is a palindrome.
   - We fill the table diagonally using the "gap strategy":
   - gap == 0: A single character is always a palindrome.
   - gap == 1: A two-character substring is a palindrome if both characters are equal.
   - gap >= 2: A substring s[i...j] is a palindrome if:
   - The first and last characters are equal: `s[i] == s[j]`
   - And the inner substring `s[i+1...j-1]` is also a palindrome → this is stored in `boolTable[i+1][j-1]`
   - So: `boolTable[i][j] = s[i] == s[j] && boolTable[i+1][j-1]`
   
   2. Compute Minimum Cuts (countTable):
   - We define `countTable[i]` as the minimum number of cuts needed to partition s[0...i] into palindromic substrings.
   - If s[0...i] is itself a palindrome, then no cuts are needed → `countTable[i] = 0`
   - Otherwise, we iterate through every possible partition point j ∈ [1...i]:
   - If s[j...i] is a palindrome, we try a cut at j-1:
   - The number of cuts becomes `countTable[j-1] + 1`
   - We take the minimum of all such valid cuts for `countTable[i]`
   
   The final result is stored in `countTable[n-1]`, which gives the minimum number of cuts required to partition the full string into palindromes.
   */
  func minCut(_ s: String) -> Int {
    var array = Array(s)
    var len = s.count
    var boolTable = Array(repeating: Array(repeating: false, count: len), count: len)
    
    //gap strategy
    for gap in 0 ..< len {
      for i in 0 ..< (len - gap) {
        var j = gap + i
        if i == j {
          boolTable[i][j] = true
        } else if j == i+1 {
          boolTable[i][j] = array[i] == array[j] ? true : false
        } else {
          boolTable[i][j] = array[i] == array[j] ? boolTable[i+1][j-1] : false
        }
      }
    }
    
    var countTable = Array(repeating: len-1, count: len)
    countTable[0] = 0
    
    for i in 0 ..< len {
      if boolTable[0][i] {
        countTable[i] = 0
        continue
      }
      var minCuts = Int.max
      for j in 1 ... i {
        //check if the part i.e. String(array[j ... i]) is palindrome or not.
        if boolTable[j][i] {
          var cuts = countTable[j-1] + 1
          minCuts = min(minCuts, cuts)
        }
      }
      countTable[i] = minCuts
    }
    return countTable[len - 1]
  }
  
  
  /*
   Leetcode 1547: Minimum Cost to Cut a Stick
   0   1   3   4   5   7
   0   0   0   3
   1   0   0   0   3
   3   0   0   0   0   2
   4   0       0   0   0   3
   5   0           0   0   0
   7   0               0   0
   
   for 0-4 => we have options as 1->3 or 3->1
   if 1->3 then answer will be 4 + 0-1 + 1-4
   if 3->1 then answer will be 4 + 0-3 + 3-4
   for 0-5
   we have 5 + 0-1 + 1-5
   5 + 0-3 + 3-5
   5 + 0-4 + 4-5
   
   we use gap strategy
   */
  func minCost(_ n: Int, _ cuts: [Int]) -> Int {
    var allCuts = [0] + cuts.sorted() + [n]
    let len = allCuts.count
    var dp = Array(repeating: Array(repeating: 0, count: len), count: len)
    
    for gap in 2..<len {
      for i in 0..<(len - gap) {
        let j = i + gap
        var minCost = Int.max
        for k in (i + 1)..<j {
          let cost = dp[i][k] + dp[k][j] + (allCuts[j] - allCuts[i])
          minCost = min(minCost, cost)
        }
        dp[i][j] = minCost
      }
    }
    
    return dp[0][len - 1]
  }
  
  /*
   Leetcode 188: Best Time to Buy and Sell Stock IV
   2   4   1
   0   0   0   0
   1   0   2   2
   2   0   2   2
   
   3   2   6   5   0   3
   0   0   0   0   0   0   0
   1   0   0   4   4   4   4
   2   0   0   4   4   4   7
   
   formula: for k in 0:j-1 {
   of maxProfit = max(maxProfit, dp[i-1][k] + price[j] - price[k])
   totalMaxProfit = max(maxProfit, dp[i][j-1])
   }
   
   Now, we can even reduce the loop of k by maintaining a maxValue variable.
   Just store, the dp[i-1][k] - price[k] in maxValue and use it in the formula.
   */
  func maxProfit(_ k: Int, _ p: [Int]) -> Int {
    var dp = Array(repeating: Array(repeating: 0, count: p.count), count: k + 1)
    for i in 1 ... k {
      var maxValue = Int.min
      for j in 1 ..< p.count {
        maxValue = max(maxValue, dp[i-1][j-1] - p[j-1])
        dp[i][j] = max(dp[i][j-1], maxValue + p[j])
      }
    }
    return dp[k][p.count-1]
  }
  
  /*
   Leetcode 337: House Robber III
   */
  func rob(_ root: TreeNode?) -> Int {
    if root == nil {
      return 0
    }
    func getMaxProfit(_ root: TreeNode?) -> (Int, Int) {
      guard let node = root else { return (0,0) }
      
      var (leftInclude, leftExclude) = getMaxProfit(node.left)
      var (rightInclude, rightExclude) = getMaxProfit(node.right)
      
      var include = leftExclude + rightExclude + node.val
      var exclude = max(leftInclude, leftExclude) + max(rightInclude, rightExclude)
      
      return (include, exclude)
    }
    var (include, exclude) = getMaxProfit(root)
    return max(include, exclude)
  }
  
  
  
  public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
      self.val = val
      self.left = left
      self.right = right
    }
  }
}
