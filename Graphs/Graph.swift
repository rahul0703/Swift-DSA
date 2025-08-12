//
//  Graph_level_1.swift
//  DSA
//
//  Created by Rahul Sureka on 04/08/25.
//

import Foundation

class Graph {
  /*
   Question: Get all paths from start to end in a directed graph
   */
  func getAllPaths(_ graph: [[Int]], _ start: Int, _ end: Int) -> [[Int]] {
    var result: [[Int]] = []
    var visited = Array(repeating: false, count: graph.count)
    var path: [Int] = []
    visited[start] = true
    getAllPathsHelper(graph, &visited, start, end, &result, &path)
    return result
  }
  
  private func getAllPathsHelper(graph: [[Int]], visited: inout [Bool], start: Int, end: Int, result: inout [[Int]], path: inout [Int]) {
    if start == end {
      path.append(start)
      result.append(path)
      path.removeLast() // Remove the current node from path before returning
      return
    }
    //Add current node to path
    path.append(start)
    //Call to all neighbours
    for neighbor in graph[start] {
      if !visited[neighbor] {
        visited[neighbor] = true
        getAllPathsHelper(graph: graph, visited: &visited, start: neighbor, end: end, result: &result, path: &path)
        //Backtrack
        visited[neighbor] = false
      }
    }
    path.removeLast() // Remove the current node from path before returning
  }
  
  /*
    Question: Get connected components of the graph
   */
  func getConnectedComponents(_ graph: [[Int]]) -> [[Int]] {
    var result: [[Int]] = []
    var visited = Array(repeating: false, count: graph.count)
    for i in 0 ..< graph.count {
      if !visited[i] {
        var path: [Int] = []
        exploreComponents(graph, &visited, i, &path)
        result.append(path) // Add the found component to the result
      }
    }
    return result
  }
  
  private func exploreComponents(_ graph: [[Int]], _ visited: inout [Bool], _ node: Int, _ path: inout [Int]) {
    
    visited[node] = true
    path.append(node)
    for neighbor in graph[node] {
      if !visited[neighbor] {
        exploreComponents(graph, &visited, neighbor, &path)
      }
    }
  }
  
  /*
   Question: Check if the graph is connected
   */
  func isGraphConnected(_ graph: [[Int]]) -> Bool {
    var result = getConnectedComponents(graph)
    if result.count == 1 {
      return true // Graph is connected if there's only one component
    } else {
      return false
    }
  }
  
  /*
   Question: Count number of islands in a grid
   */
  func countNumberOfIslands(_ grid: [[Int]]) -> Int {
    var count = 0
    var visited = Array(repeating: Array(repeating: false, count: grid[0].count), count: grid.count)
    for i in 0 ..< grid.count {
      for j in 0 ..< grid[i].count {
        if visited[i][j] == false && grid[i][j] == 1 {
          count += 1 // Found a new island
          exploreIsland(grid, &visited, i, j)
        }
      }
    }
    return count
  }
  
  private func exploreIsland(_ grid: [[Int]], _ visited: inout [[Bool]], _ row: Int, _ col: Int) {
    if row < 0 || row >= grid.count || col < 0 || col >= grid[row].count || visited[row][col] || grid[row][col] == 0 {
      return
    }
    visited[row][col] = true
    //neighbour of 4 directions
    let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
    
    for direction in directions {
      exploreIsland(grid, &visited, row + direction.0, col + direction.1)
    }
  }
  
  /*
   Question: Perfect friends problem
   Desc: Given a graph, find the number of perfect friends pairs where no two friends are connected directly or indirectly.
   */
  func countPerfectFriendsPairs(_ graph: [[Int]]) -> Int {
    var answer: [Int] = []
    var visited = Array(repeating: false, count: graph.count)
    for i in 0 ..< graph.count {
      var  count = 0
      if !visited[i] {
        countPerfectFriendsPairsHelper(graph, &visited, i, &count)
        answer.append(count) // Add the count of friends in this component
      }
    }
    var totalPairs = 0
    for i in 0 ..< answer.count {
      for j in i + 1 ..< answer.count {
        totalPairs += answer[i] * answer[j] // Count pairs from different components
      }
    }
    return totalPairs
  }
  
  private func countPerfectFriendsPairsHelper(_ graph: [[Int]], _ visited: inout [Bool], _ node: Int, _ count: inout Int) {
    visited[node] = true
    count += 1 // Increment the count of friends in this component
    
    for neighbor in graph[node] {
      if !visited[neighbor] {
        countPerfectFriendsPairsHelper(graph, &visited, neighbor, &count)
      }
    }
  }
  
  /*
   Question: Hamiltonian path problem
   Desc: Given a graph, find if there exists a Hamiltonian path in the graph. Where Hamiltonian path is a path that visits every vertex exactly once.
   Sol: This is very similar to getAllPaths problem, just the base case is different! There base case is if destination is reached and here along with that we also check if all nodes are visited.
   */
  func getAllHamiltonianPaths(_ graph: [[Int]], start: Int) -> [[Int]] {
    var result: [[Int]] = []
    var visited = Array(repeating: false, count: graph.count)
    var path: [Int] = []
    getAllHamiltonianPathHelper(graph, &visited, start, &result, &path)
    return result
  }
  
  private func getAllHamiltonianPathHelper(graph: [[Int]], visited: inout [Bool], start: Int, result: inout [[Int]], path: inout [Int]) {
    visited[start] = true
    path.append(start)
    
    if path.count == graph.count {
      result.append(path) // Found a Hamiltonian path
    } else {
      for neighbor in graph[start] {
        if !visited[neighbor] {
          getAllHamiltonianPathHelper(graph: graph, visited: &visited, start: neighbor, result: &result, path: &path)
        }
      }
    }
    path.removeLast() // Remove the current node from path before returning
    visited[start] = false // Backtrack
  }
  
  /*
   Question: check if hamiltonian cycle exists
   Desc: Given a graph, find if there exists a Hamiltonian cycle in the graph, where a Hamiltonian cycle is a cycle that visits every vertex exactly once and returns to the starting vertex.
   */
  func isHamiltonianCycleExists(_ graph: [[Int]], start: Int) -> Bool {
    var visited = Array(repeating: false, count: graph.count)
    var path: [Int] = []
    return getAllHamiltonianCycleHelper(graph, &visited, start, &path)
  }
  
  private func getAllHamiltonianCycleHelper(graph: [[Int]], visited: inout [Bool], start: Int, path: inout [Int]) -> Bool {
    visited[start] = true
    path.append(start)
    
    if path.count == graph.count {
      if graph[start].contains(path[0]) {
        return true // Found a Hamiltonian cycle
      }
    } else {
      for neighbor in graph[start] {
        if !visited[neighbor] {
          var answer = getAllHamiltonianCycleHelper(graph: graph, visited: &visited, start: neighbor, path: &path)
          if answer {
            return true // If a Hamiltonian cycle is found, return true
          }
        }
      }
    }
    path.removeLast() // Remove the current node from path before returning
    visited[start] = false
    return false // No Hamiltonian cycle found in this path
  }
  
  /*
   Question: Knight Tour problem
   Desc: Given a chessboard of size n x n, find all possible paths of a knight starting from the top left corner to the bottom right corner, where no cell is visited twice.
   */
  let rowMoves = [2, 1, -1, -2, -2, -1, 1, 2]
  let colMoves = [1, 2, 2, 1, -1, -2, -2, -1]
  func findAllKnightTourPaths(n: Int) -> [[String]] {
    var matrix: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: n)
    var visited: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: n)
    var result: [[String]] = []
    var path: [String] = []
    findAllKnightTourPathsHelper(matrix: &matrix, visited: &visited, n: n, row: 0, col: 0, result: &result, path: &path)
    return result
  }
  
  private func findAllKnightTourPathsHelper(matrix: inout [[Int]], visited: inout [[Int]], n: Int, row: Int, col: Int, result: inout [[String]], path: inout [String]) {
    if row < 0 || row >= n || col < 0 || col >= n || visited[row][col] == 1 {
      return // Out of bounds or already visited
    }
    visited[row][col] = 1
    path.append("(\(row), \(col))") // Add current position to path
    
    if row == n - 1 && col == n - 1 {
      result.append(path) // Reached the bottom right corner, add path to result
    } else {
      for i in 0 ..< 8 {
        var ngr_row = row + rowMoves[i]
        var ngr_col = col + colMoves[i]
        
        findAllKnightTourPathsHelper(matrix: &matrix, visited: &visited, n: n, row: ngr_row, col: ngr_col, result: &result, path: &path)
      }
    }
    
    visited[row][col] = 0 // Backtrack by marking the cell as unvisited
    path.removeLast() // Remove the current position from path before returning
  }
  
  /*
   Question: Detect cycle in graph
   Solution: use BFS and track visited nodes, if we encounter a node already visited then cycle is present.
   Logic: If the node is enqueued more than 2 times before being marked visited, then a cycle is detected.
   */
  func detectCycleInUndirectedGraph(graph: [Int: [Int]]) -> Bool {
    var visited = Array(repeating: false, count: graph.count)
    for node in graph.keys {
      if !visited[node] {
        if bfs(graph, node, &visited) {
          return true
        }
      }
    }
    return false
  }
  
  private func bfs(_ graph: [Int: [Int]], _ start: Int, _ visited: inout [Bool]) -> Bool {
    var queue: QueueCustom<Int> = QueueCustom()
    queue.enqueue(start)
    while !queue.isEmpty() {
      let poppedNode = queue.dequeue()!
      if visited[poppedNode] {
        return true // Cycle detected
      }
      visited[poppedNode] = true
      for ngr in graph[poppedNode]! {
        if !visited[ngr] {
          queue.enqueue(ngr) // Enqueue unvisited neighbors
        }
      }
    }
    return false // No cycle detected
  }
  /*
   Find the shortest path from source to all other nodes in a weighted graph using Dijkstra's algorithm.
   */
  func dijkstraAlgorithm(_ graph: [Int: [(Int, Int)]], _ start: Int) -> [Int] {
    var answer = Array(repeating: Int.max, count: graph.count)
    var visited = Array(repeating: false, count: graph.count)
    var pq = PriorityQueue()
    var startNode = GraphNode(val: start, dist: 0)
    
    pq.enqueue(startNode)
    answer[start] = 0 // Distance to the start node is 0
    
    while !pq.isEmpty() {
      var removedNode = pq.dequeue()!
      if visited[removedNode.val] {
        continue // If the node is already visited, skip it
      }
      visited[removedNode.val] = true
      
      for ngr in graph[removedNode.val]! {
        if !visited[ngr.0] {
          let newDist = removedNode.dist + ngr.1
          answer[ngr.0] = min(answer[ngr.0], newDist) // Update the distance if it's shorter
          pq.enqueue(GraphNode(val: ngr.0, dist: newDist)) // Enqueue the neighbor with updated distance
        }
      }
    }
    return answer
  }
  /*
   Shortest length of cable to connect all compiters in a network.
   Approach: Use Prim's algorithm to find the minimum spanning tree (MST) of the graph.
   */
  func primsMST(_ graph: [Int: [(Int, Int)]]) -> Int {
    var totalCost = 0
    var visited = Array(repeating: false, count: graph.count)
    var pq = PriorityQueue()
    // 0 distance from the starting node
    var startNode = GraphNode(val: 0, dist: 0)
    pq.enqueue(startNode)
    
    while !pq.isEmpty() {
      var removedNode = pq.dequeue()!
      if visited[removedNode.val] {
        continue // If the node is already visited, skip it.
      }
      visited[removedNode.val] = true
      totalCost += removedNode.dist // Add the cost of the edge to the total cost
      for ngr in graph[removedNode.val]! {
        if !visited[ngr.0] {
          pq.enqueue(GraphNode(val: ngr.0, dist: ngr.1)) // Enqueue the neighbor with its cost
        }
      }
    }
    return totalCost // Return the total cost of the MST
  }
  /*
   
   */
  func topologicalSortUsingRecursionWithoutCycle(_ graph: [[Int]]) -> [Int] {
    var answer: [Int] = []
    var visited = Array(repeating: false, count: graph.count)
    var stack: [Int] = []
    
    for node in 0 ..< graph.count {
      if !visited[node] {
        dfsTopo(graph, node, &visited, &stack)
      }
    }
    return stack.reversed() // Return the topological order in reverse order
  }
  
  func dfsTopo(_ graph: [[Int]], _ node: Int, _ visited: inout [Bool], _ stack: inout [Int]) {
    visited[node] = true
    for ngr in graph[node] {
      if !visited[ngr] {
        dfsTopo(graph, ngr, &visited, &stack) // Recursively visit the neighbors
      }
    }
    stack.append(node) // Add the node to the stack after visiting all its neighbors while backtracking.
  }
  
  /*
   
   */
  func topoSortUsingDFSCycleDetection(_ graph: [[Int]]) -> [Int]? {
    var visited = Array(repeating: false, count: graph.count)
    var inRecursionStack = Array(repeating: false, count: graph.count)
    var stack: [Int] = []
    
    for node in 0..<graph.count {
      if !visited[node] {
        if !dfsTopo(graph, node, &visited, &inRecursionStack, &stack) {
          return nil // Cycle detected
        }
      }
    }
    return stack.reversed()
  }
  
  private func dfsTopo(_ graph: [[Int]], _ node: Int,
                       _ visited: inout [Bool],
                       _ inRecStack: inout [Bool],
                       _ stack: inout [Int]) -> Bool {
    visited[node] = true
    inRecStack[node] = true
    for neighbor in graph[node] {
      if !visited[neighbor] {
        if !dfsTopo(graph, neighbor, &visited, &inRecStack, &stack) {
          return false
        }
      } else if inRecStack[neighbor] {
        // Cycle detected
        return false
      }
    }
    inRecStack[node] = false
    stack.append(node)
    return true
  }
  
  /*
   Topological sort Iterative using Kahn's algorithm
   Approach:
    1. Fill a array based on degree of each node. Where degree is number of incoming edges.
    2. Use a queue to process nodes with zero incoming edges and reduce the degree of their ngrs. If the ngr degree is 0 then append into queue and add the count.
    3. Repeat until the queue is empty.
    4. If, queue is empty and not all nodes are processed (count != n) then cycle is present.
   */
  func kahnsTopologicalSort(_ graph: [[Int]]) -> [Int] {
    var count = graph.count
    var nDegree = Array(repeating: 0, count: graph.count)
    var queue: [Int] = []
    //Loop over the graph to fill ndegree array
    for i in 0 ..< graph.count {
      for ngr in graph[i] {
        nDegree[ngr] += 1
      }
    }
    for i in 0 ..< nDegree.count {
      if nDegree[i] == 0 {
        queue.append(i) // If degree is 0 then add to queue
      }
    }
    var answer: [Int] = []
    var count = 0 // Count of nodes processed
    while(!queue.isEmpty) {
      var poppedNode = queue.removeFirst()
      answer.append(poppedNode) // Add the node to the answer
      count += 1
      for ngr in graph[poppedNode] {
        nDegree[ngr] -= 1 // Reduce the degree of the neighbor
        if nDegree[ngr] == 0 {
          queue.append(ngr) // If degree becomes 0 then add to queue
        }
      }
    }
    if count != graph.count {
      return [] // Cycle detected, return empty array
    }
    return answer // Return the topological order
  }
  
  /*
   Question: Find the minimum number of edge swap to reach from source to estination in a directed graaph.
   Solution:
      1. We need to make the directed graph into undirected graph. To do so, we need to add a reverse edge with cost 1.
      2. Use Dijkstra's algorithm to find the shortest path from source to destination.
      3. But, if you notice the edge weights are either 0 or 1, so we can use 0-1 BFS to find the shortest path.
   */
  func minEdgeSwapToReachDesitiation(_ graph: [[Int]], _ source: Int, _ destination: Int) -> Int {
    var size = graph.count
    if size == 0 || source < 0 || destination < 0 || source >= size || destination >= size || source == destination {
      return 0
    }
    var newGraph = Array(repeating: [(Int, Int)](), count: size)
    for i in 0 ..< size {
      for ngr in graph[i] {
        newGraph[i].append((ngr, 0)) // Add the original edge with cost 0
        newGraph[ngr].append((i, 1)) // Add the reverse edge with cost 1
      }
    }
    var visited: [Bool] = Array(repeating: false, count: size)
    var queue: [(Int, Int)] = []
    queue.append((source, 0))
    
    while !queue.isEmpty {
      var poppedNode = queue.removeFirst()
      if visited[node] {
          continue
      }
      visited[poppedNode.0] = true // Mark the node as visited
      if poppedNode.0 == destination {
        return poppedNode.1 // If we reached the destination, return the answer
      }
      
      for (ngr, cost) in newGraph[poppedNode.0] {
        if !visited[ngr] {
          if cost == 0 {
            queue.insert((ngr, poppedNode.1), at: 0) // If cost is 0, add to front of queue
          } else {
            queue.append((ngr, poppedNode.1 + cost)) // If cost is 1, add to back of queue
          }
        }
      }
    }
    return -1 // If we reach here, it means we couldn't reach the destination
  }
  
  /*
   Minimum Spanning Tree using Krushkal's Algorithm
   Approcach:
    1. Sort the edges based on their weights.
    2. Use a union-find data structure to keep track of connected components.
    3. Iterate through the sorted edges and add them to the MST.
    4. Add thw weights of the edges to the total cost.
   */
  func MSTWithKrushkalAlgorithm(_ graph: [[Int]]) -> Int {
    //graph[i] = [u, v, weight]
    var graph = graph.sorted { $0[2] < $1[2] } // Sort edges based on weights
    var answer = 0
    let n = graph.flatMap { [$0[0], $0[1]] }.max()! + 1
    var parent = Array(repeating: -1, count: n)
    var rank = Array(repeating: 0, count: n)
    
    for edge in graph {
      let u = edge[0]
      let v = edge[1]
      
      if findParent(u, &parent) != findParent(v, &parent) {
        union(u, v, &parent, &rank) // Union the two components
        answer += edge[2] // Add the weight of the edge to the total cost
      }
    }
    return answer // Return the total cost of the MST
  }
  
  private func findParent(_ node: Int, _ parent: inout [Int]) -> Int {
    if parent[node] == -1 {
      return node // If the node is its own parent, return it
    }
    parent[node] = findParent(parent[node], &parent) // Path compression
    return parent[node] // Return the parent of the node
  }
  
  private func union(_ u: Int, _ v: Int, _ parent: inout [Int], _ rank: inout [Int]) {
    let parentU = findParent(u, &parent)
    let parentV = findParent(v, &parent)
    let rankU = rank[parentU]
    let rankV = rank[parentV]
    
    if rankU > rankV {
      parent[parentV] = parentU // Make parentU the parent of parentV
    } else if rankU < rankV {
      parent[parentU] = parentV // Make parentV the parent of parentU
    } else {
      parent[parentV] = parentU // Make parentU the parent of parentV
      rank[parentU] += 1 // Increment the rank of parentU
    }
  }
  
  /*
   Shortest path in a directed graph with negative weights using Bellman-Ford algorithm
   */
  func bellmanFord(_ graph: [[Int]], _ source: Int) -> [Int]? {
    //graph[i] = [u, v, weight]
    var length = graph.flatMap { [$0[0], $0[1]] }.max()! + 1
    var answer = Array(repeating: Int.max, count: length)
    answer[source] = 0 // Distance to the source is 0
    
    for _ in 0 ..< length - 1 {
      for edge in graph {
        let u = edge[0]
        let v = edge[1]
        let weight = edge[2]
        if answer[u] != Int.max {
          answer[v] = min(answer[v], answer[u] + weight) // Relax the edge
        }
      }
    }
    var newArray = answer
    for edge in graph {
      if newArray[edge[0]] != Int.max {
        newArray[edge[1]] = min(newArray[edge[1]], newArray[edge[0]] + edge[2]) // Relax the edge again to check for negative cycles
      }
    }
    if answer == newArray {
      return answer
    }
    return nil
  }
}



