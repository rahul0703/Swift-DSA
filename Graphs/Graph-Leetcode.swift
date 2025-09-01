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
  
  /*
   Leetcode 1293: Shortest Path in a Grid with Obstacles Elimination
   Very Important Question
   */
  func shortestPath(_ grid: [[Int]], _ k: Int) -> Int {
    var rows = grid.count
    var cols = grid[0].count
    var queue: [(x: Int, y: Int, steps: Int, eliminated: Int)] = []
    var visited = Array(repeating: Array(repeating: Set<Int>(), count: cols), count: rows)
    
    queue.append((0, 0, 0, 0))
    
    while !queue.isEmpty {
      //Remove
      let (x, y, steps, eliminated) = queue.removeFirst()
      
      //Check Visited
      if visited[x][y].contains(eliminated) {
        continue
      }
      
      //Mark Visited
      visited[x][y].insert(eliminated)
      
      //Work
      if x == rows - 1 && y == cols - 1 {
        return steps
      }
      
      //Add Ngrs
      var directions = [(0,1), (0,-1), (1,0), (-1,0)]
      for dir in directions {
        let nx = x + dir.0
        let ny = y + dir.1
        
        if nx >= 0 && nx < rows && ny >= 0 && ny < cols {
          let isObstacle = grid[nx][ny] == 1
          let newEliminated = eliminated + (isObstacle ? 1 : 0)
          
          if newEliminated <= k && !visited[nx][ny].contains(newEliminated) {
            queue.append((nx, ny, steps + 1, newEliminated))
          }
        }
      }
    }
    return -1
  }
  
  /*
   Question leetcode 207: Course Schedule
   Desc: There are a total of numCourses courses you have to take, labeled from 0 to numCourses-1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.
   Approach: Use Kahn's algorithm to detect cycle in directed graph
   */
  func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
    var graph: [[Int]] = Array(repeating: [], count: numCourses)
    var nDegree = Array(repeating: 0, count: numCourses)
    for edges in prerequisites {
      nDegree[edges[0]] += 1
      graph[edges[1]].append(edges[0])
    }
    var queue: [Int] = []
    for i in 0 ..< numCourses {
      if nDegree[i] == 0 {
        queue.append(i)
      }
    }
    while !queue.isEmpty {
      var popped = queue.removeFirst()
      for ngr in graph[popped] {
        nDegree[ngr] -= 1
        if nDegree[ngr] <= 0 {
          queue.append(ngr)
        }
      }
    }
    for val in nDegree {
      if val > 0 {
        return false
      }
    }
    return true
  }
  
  /*
   Leetcode 269: Alien Dictionary
   Desc: There is a new alien language which uses the English alphabet. However, the order among letters are unknown to you. You receive a list of non-empty words from the dictionary, where words are sorted lexicographically by the rules of this new language. Derive the order of letters in this language.
   Approach:
   1. Build a graph using adjacent word pairs to determine character order
   2. Perform topological sort (Kahn's algorithm) to find valid character order
   Edge Cases:
   - Prefix violation (e.g., "abc" before "ab") → invalid order
   */
  func alienOrder(_ words: [String]) -> String {
    var graph = [Character: [Character]]()
    var inDegree = [Character: Int]()
    
    // Initialize graph with all unique letters
    for word in words {
      for char in word {
        graph[char] = []
        inDegree[char] = 0
      }
    }
    
    // Build graph using adjacent word pairs
    for i in 0..<words.count - 1 {
      let w1 = Array(words[i])
      let w2 = Array(words[i + 1])
      let minLen = min(w1.count, w2.count)
      var foundDiff = false
      
      for j in 0..<minLen {
        if w1[j] != w2[j] {
          let from = w1[j]
          let to = w2[j]
          if !(graph[from]?.contains(to) ?? false) {
            graph[from]?.append(to)
            inDegree[to, default: 0] += 1
          }
          foundDiff = true
          break
        }
      }
      
      // Edge case: prefix violation → invalid order
      if !foundDiff && w1.count > w2.count {
        return ""
      }
    }
    
    // Topological sort using Kahn's algorithm
    var queue = [Character]()
    for (char, degree) in inDegree {
      if degree == 0 {
        queue.append(char)
      }
    }
    
    var result = ""
    while !queue.isEmpty {
      let current = queue.removeFirst()
      result.append(current)
      for neighbor in graph[current] ?? [] {
        inDegree[neighbor]! -= 1
        if inDegree[neighbor] == 0 {
          queue.append(neighbor)
        }
      }
    }
    
    return result.count == inDegree.count ? result : ""
  }
  
  /*
   Leetcode 310: Minimum Height Trees
   Very Important Question
   Approach:
   1. Build the graph as an adjacency list
   2. Find all leaves (nodes with degree 1)
   3. While the number of nodes left > 2:
   a. Remove all current leaves
   b. Update neighbors’ degrees
   c. Add new leaves to the queue
   d. Return remaining nodes — these are the centroids
   
   Odd-length trees have 1 central node → 1 centroid
   Even-length trees have 2 central nodes → 2 centroids
   */
  func findMinHeightTrees(_ n: Int, _ edges: [[Int]]) -> [Int] {
    if n == 1 { return [0] }
    // Step 1: Build the graph
    var graph = Array(repeating: Set<Int>(), count: n)
    for edge in edges {
      let u = edge[0], v = edge[1]
      graph[u].insert(v)
      graph[v].insert(u)
    }
    // Step 2: Initialize leaves (degree 1)
    var leaves = [Int]()
    for i in 0..<n {
      if graph[i].count == 1 {
        leaves.append(i)
      }
    }
    var remainingNodes = n
    // Step 3: Trim leaves layer by layer
    while remainingNodes > 2 {
      remainingNodes -= leaves.count
      var newLeaves = [Int]()
      
      for leaf in leaves {
        let neighbor = graph[leaf].first!
        graph[neighbor].remove(leaf)
        if graph[neighbor].count == 1 {
          newLeaves.append(neighbor)
        }
      }
      leaves = newLeaves
    }
    return leaves
  }
  
  /*
   Leetcode 1928: Minimum Cost to Reach Destination in Time
   Approach: Dijkstra's algorithm with a priority queue to explore the least-cost paths within the time constraint.
   Very important question
   */
  func minCost(_ maxTime: Int, _ edges: [[Int]], _ passingFees: [Int]) -> Int {
    var graph: [Int: [(Int, Int)]] = [:]
    var n = passingFees.count
    var pq = PriorityQueueCustom<(Int, Int, Int)> { // (node, cost, time)
      if $0.1 == $1.1 {
        return $0.2 < $1.2
      }
      return $0.1 < $1.1
    }
    var visited: [Int: Int] = [:]
    
    //build graph
    for edge in edges {
      var u = edge[0]
      var v = edge[1]
      var time = edge[2]
      
      graph[v, default: []].append((u, time))
      graph[u, default: []].append((v, time))
    }
    pq.push((0, passingFees[0], 0))
    while !pq.isEmpty() {
      //Remove
      var (node, cost, time) = pq.pop()!
      print("node \(node) with cost \(cost)")
      //Check Visited
      if visited.keys.contains(node) && visited[node]! <= time {
        continue
      }
      //Mark Visited
      visited[node] = time
      //Work
      if node == n-1 {
        return cost
      }
      //Add ngrs
      for tuple in graph[node, default: []] {
        var ngr = tuple.0
        var distance = tuple.1
        if time + distance > maxTime || (visited.keys.contains(ngr) && visited[ngr]! <= time + distance) {
          continue
        }
        pq.push((ngr, cost + passingFees[ngr], time + distance))
      }
    }
    return -1
  }
  
  /*
   Leetcode 778: Swim in Rising Water
   */
  func swimInWater(_ grid: [[Int]]) -> Int {
    var rows = grid.count
    var cols = grid[0].count
    var visited = Array(repeating: Array(repeating: false, count: cols), count: rows)
    var pq = PriorityQueueCustom<(Int, Int, Int)> {$0.2 < $1.2}
    pq.push((0, 0, grid[0][0]))
    
    while !pq.isEmpty() {
      //Remove
      var (x, y, cost) = pq.pop()!
      //Check visisted
      if visited[x][y] {
        continue
      }
      //Mark Visited
      visited[x][y] = true
      //work
      if x == rows-1 && y == cols - 1 {
        return cost
      }
      //Add ngr
      var dist = [(0,1), (0, -1), (1, 0), (-1,0)]
      for i in 0 ..< 4 {
        var ngrX = x + dist[i].0
        var ngrY = y + dist[i].1
        
        if ngrX >= 0 && ngrX < rows && ngrY >= 0 && ngrY < cols && !visited[ngrX][ngrY] {
          var maxCost = max(cost, grid[ngrX][ngrY])
          pq.push((ngrX, ngrY, maxCost))
        }
      }
    }
    return -1
  }
  /*
   Leetcode 1631: Path With Minimum Effort
   */
  func minimumEffortPath(_ heights: [[Int]]) -> Int {
    var pq = PriorityQueueCustom<(Int, Int, Int)>{$0.2 < $1.2}
    var rows = heights.count
    var cols = heights[0].count
    var visited = Array(repeating: Array(repeating: false, count: cols), count: rows)
    
    pq.push((0, 0, 0))
    
    while !pq.isEmpty() {
      //Remove
      var (x, y, cost) = pq.pop()!
      //Check visited
      if visited[x][y] {
        continue
      }
      //Mark Visited
      visited[x][y] = true
      //work
      if x == rows - 1 && y == cols - 1 {
        return cost
      }
      //Add ngrs
      var distX = [1, -1, 0, 0]
      var distY = [0, 0, -1, 1]
      for i in 0 ..< 4 {
        var newX = x + distX[i]
        var newY = y + distY[i]
        
        if newX >= 0 && newX < rows && newY >= 0 && newY < cols && !visited[newX][newY] {
          var newCost = max(cost, abs(heights[x][y] - heights[newX][newY]))
          pq.push((newX, newY, newCost))
        }
      }
    }
    return -1
  }
  
  /*
   Leetcode 1168: Optimize Water Distribution in a Village
   Very important question
   Question: There are n houses in a village.
   You are given an integer n and a 2D array pipes, where pipes[i] = [house1, house2, cost] represents the cost to connect house1 and house2 with a pipe.
   You are also given an array wells, where wells[i] is the cost to build a well in the (i + 1)-th house.
   Return the minimum total cost to supply water to all houses.
   
   Intution:If wells were not given, this would be a minimum spanning tree problem. but, to consider well, what we can do is
   1. Add a new node to the graph representing the well and connect that node to all the houses with the cost of the well for that house.
   2. Then, we can run the minimum spanning tree algorithm to find the minimum cost
   */
  func minCostToSupplyWater(_ n: Int, _ wells: [Int], _ pipes: [[Int]]) -> Int {
    var visited = Array(repeating: false, count: n + 1)
    
    //Make the edges graph
    var edges = pipes
    for i in 0 ..< n {
      edges.append([0, i + 1, wells[i]]) // Add edges from well to each house
    }
    //Sort the edges based on cost
    edges.sort { $0[2] < $1[2] }
    var totalCost = 0
    
    //Construct parent and rank array
    var parent = Array(repeating: 0, count: n + 1)
    var rank = Array(repeating: 0, count: n + 1)
    
    for i in 0 ..< n + 1 {
      parent[i] = i // Initialize parent for each node
      rank[i] = 0 // Initialize rank for union-find
    }
    
    //Loop over edges
    for edge in edges {
      var u = edge[0]
      var v = edge[1]
      var cost = edge[2]
      
      //Run DSU
      var parent1 = findParentSupplyWater(u, &parent)
      var parent2 = findParentSupplyWater(v, &parent)
      
      if parent1 != parent2 {
        totalCost += cost
        unionSupplyWater(parent1, parent2, &parent, &rank) // Union the two sets
      }
    }
    return totalCost
  }
  func findParentSupplyWater(_ x: Int, _ parent: inout [Int]) -> Int {
    if parent[x] == x {
      return x // If x is the root, return x
    }
    
    return parent[x] = findParentSupplyWater(parent[x], &parent)
  }
  func unionSupplyWater(_ x: Int, _ y: Int, _ parent: inout [Int], _ rank: inout [Int]) {
    if rank[x] > rank[y] {
      parent[y] = x // Attach y to x
    } else if rank[y] > rank[x] {
      parent[x] = y // Attach x to y
    } else {
      parent[y] = x // Attach y to x and increment rank of x
      rank[x] += 1
    }
  }
  
  /*
   Leetcode 721: Accounts merge
   Very important question
   */
  func accountsMerge(_ accounts: [[String]]) -> [[String]] {
    var hashMap: [String: String] = [:]
    var edges: [(String, String)] = []
    //Fill the HashMao
    for account in accounts {
      var name = account[0]
      for i in 1 ..< account.count {
        var email = account[i]
        hashMap[email] = name
        
        if i < account.count - 1 {
          var email1 = account[i]
          var email2 = account[i+1]
          edges.append((email1, email2))
        }
      }
    }
    
    var length = hashMap.count
    var parent: [String: String] = [:]
    var rank: [String: Int] = [:]
    
    for key in hashMap.keys {
      parent[key] = key // Initialize parent for each node
      rank[key] = 0 // Initialize rank for union-find
    }
    
    for edge in edges {
      var email1 = edge.0
      var email2 = edge.1
      
      var parent1 = findParent(email1, &parent)
      var parent2 = findParent(email2, &parent)
      
      if parent1 != parent2 {
        union(parent1, parent2, &rank, &parent)
      }
    }
    var answerMap: [String: [String]] = [:]
    var answer: [[String]] = []
    for email in hashMap.keys {
      var parent = findParent(email, &parent)
      if let _ = answerMap[parent] {
        answerMap[parent]!.append(email)
      } else {
        answerMap[parent] = [email]
      }
    }
    
    for (key, value) in answerMap {
      var subAnswer: [String] = []
      var name = hashMap[key]!
      subAnswer.append(name)
      var value = value
      value.sort()
      for val in value {
        subAnswer.append(val)
      }
      answer.append(subAnswer)
    }
    return answer
  }
  func findParent(_ x: String, _ parent: inout [String: String]) -> String {
    // Safely unwrap parent[x]
    guard let px = parent[x] else {
      fatalError("Parent mapping for '\(x)' not found.")
    }
    
    if px == x {
      return x // x is the root
    }
    
    let root = findParent(px, &parent)
    parent[x] = root // path compression
    return root
  }
  
  func union(_ x: String, _ y: String, _ rank: inout [String: Int], _ parent: inout [String: String]) {
    guard let rankX = rank[x], let rankY = rank[y] else {
      fatalError("Rank not initialized for '\(x)' or '\(y)'")
    }
    
    if rankX > rankY {
      parent[y] = x
    } else if rankY > rankX {
      parent[x] = y
    } else {
      parent[y] = x
      rank[x] = rankX + 1
    }
  }
  
  /*
   Leetcode 1036: Escape a Large Maze
   very important question
   Intution:
   1. Blocked noded length is 200 so, at max they can block 200*(200-1)/2 = 19900 nodes.
   2. We just need to check,
   a. If souce to target is reachble than return true
   b. Or, if we can move more than 19900 moves from both source and target than both are not surrounded and return true.
   c. If any of the source or target is sourrounded and source to target no path exists then return false.
   */
  func isEscapePossible(_ blocked: [[Int]], _ source: [Int], _ target: [Int]) -> Bool {
    var blockedNodes = Set<Node>()
    for node in blocked {
      var x = node[0]
      var y = node[1]
      blockedNodes.insert(Node(x,y))
    }
    var answer1 = checkBFSEscapePossible(source, target, blockedNodes)
    var answer2 = checkBFSEscapePossible(target, source, blockedNodes)
    
    return answer1 && answer2
    
  }
  func checkBFSEscapePossible(_ source: [Int], _ target: [Int], _ blockedNodes: Set<Node>) -> Bool {
    var size = 1000000
    var visited = Set<Node>()
    var queue: [(Int, Int)] = []
    queue.append((source[0], source[1]))
    var count = 0
    while !queue.isEmpty {
      //Remove
      var (x, y) = queue.removeFirst()
      //Check visited
      if visited.contains(Node(x,y)) {
        continue
      }
      //Mark visited
      visited.insert(Node(x,y))
      //work
      if visited.count > 20000 || (x == target[0] && y == target[1]){
        return true
      }
      //Add ngr
      var dist = [(1,0),(0,1),(-1,0),(0,-1)]
      for i in 0 ..< 4 {
        var newX = x + dist[i].0
        var newY = y + dist[i].1
        
        if newX >= 0 && newX < size && newY >= 0 && newY < size && !visited.contains(Node(newX, newY)) && !blockedNodes.contains(Node(newX, newY)) {
          queue.append((newX, newY))
        }
      }
    }
    return false
  }
  
  struct Node: Hashable {
    let x: Int
    let y: Int
    
    init(_ x: Int, _ y: Int) {
      self.x = x
      self.y = y
    }
  }
  
  /*
   Leetcode 329: Longest Increasing Path in a Matrix
   */
  func longestIncreasingPath(_ matrix: [[Int]]) -> Int {
    let rows = matrix.count
    let cols = matrix[0].count
    let directions = [(1,0), (-1,0), (0,1), (0,-1)]
    var memo = Array(repeating: Array(repeating: 0, count: cols), count: rows)
    
    func dfs(_ row: Int, _ col: Int) -> Int {
      // If already computed, return memoized result
      if memo[row][col] != 0 {
        return memo[row][col]
      }
      
      let currentValue = matrix[row][col]
      var maxLength = 1 // Minimum path length is 1 (the cell itself)
      
      for dir in directions {
        let newRow = row + dir.0
        let newCol = col + dir.1
        
        // Check bounds and strictly increasing condition
        if newRow >= 0, newRow < rows, newCol >= 0, newCol < cols,
           matrix[newRow][newCol] > currentValue {
          maxLength = max(maxLength, 1 + dfs(newRow, newCol))
        }
      }
      
      memo[row][col] = maxLength
      return maxLength
    }
    
    var result = 0
    for r in 0..<rows {
      for c in 0..<cols {
        result = max(result, dfs(r, c))
      }
    }
    
    return result
  }
  
  /*
   Leetcode 1192: Critical Connections in a Network
   Tarjan's Algorithm
   */
  func criticalConnections(_ n: Int, _ connections: [[Int]]) -> [[Int]] {
    // 1. Build adjacency list
    var graph = [Int: [Int]]()
    for connection in connections {
      let u = connection[0]
      let v = connection[1]
      graph[u, default: []].append(v)
      graph[v, default: []].append(u)
    }
    
    // 2. Track discovery time, lowest reachable time, and visited
    var disc = Array(repeating: -1, count: n)
    var low = Array(repeating: -1, count: n)
    var visited = Array(repeating: false, count: n)
    
    // 3. Global timer
    var timer = 0
    
    // 4. Result
    var bridges = [[Int]]()
    
    // 5. DFS
    func dfs(_ curr: Int, _ parent: Int) {
      visited[curr] = true
      disc[curr] = timer
      low[curr] = timer
      timer += 1
      
      for neighbor in graph[curr]! {
        if neighbor == parent {
          continue // Don't go back through the edge we came from
        }
        
        if !visited[neighbor] {
          dfs(neighbor, curr)
          
          // Update low after returning from DFS
          low[curr] = min(low[curr], low[neighbor])
          
          // Bridge condition
          if low[neighbor] > disc[curr] {
            bridges.append([curr, neighbor])
          }
        } else {
          // Back edge
          low[curr] = min(low[curr], disc[neighbor])
        }
      }
    }
    
    // 6. Start DFS from node 0
    dfs(0, -1)
    
    return bridges
  }
  
  /*
   Leetcode 210: Course Schedule II
   */
  func findTaskOrder(_ n: Int, _ prerequisites: [[Int]]) -> [Int] {
    var graph = [Int: [Int]]()
    for edge in prerequisites {
      let from = edge[1], to = edge[0]
      graph[from, default: []].append(to)
    }
    
    var stack = [Int]()
    var visited = Array(repeating: 0, count: n)  // 0 = unvisited, 1 = visiting, 2 = visited
    
    func dfs(_ node: Int) -> Bool {
      if visited[node] == 1 {
        return false  // Cycle found
      }
      if visited[node] == 2 {
        return true  // Already processed
      }
      
      visited[node] = 1  // Mark as visiting
      
      for neighbor in graph[node, default: []] {
        if !dfs(neighbor) {
          return false
        }
      }
      
      visited[node] = 2  // Mark as fully processed
      stack.append(node)
      return true
    }
    
    for node in 0..<n {
      if visited[node] == 0 {
        if !dfs(node) {
          return []
        }
      }
    }
    
    return stack.reversed()
  }
  
}

