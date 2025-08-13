//
//  BinaryTree.swift
//  DSA
//
//  Created by Rahul Sureka on 10/08/25.
//

import Foundation

class BinaryTree {
  class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init() { self.val = 0; self.left = nil; self.right = nil; }
    init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
      self.val = val
      self.left = left
      self.right = right
    }
  }
  
  /*
   Question Leetcode 872:
   */
  func leafSimilar(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
    var array1: [Int] = []
    var array2: [Int] = []
    
    fillLeafArray(root1, &array1)
    fillLeafArray(root2, &array2)
    
    return array1 == array2
  }
  
  private func fillLeafArray(_ root: TreeNode?, _ array: inout [Int]) {
    guard let node = root else { return }
    if node.left == nil && node.right == nil {
      array.append(node.val)
    } else {
      fillLeafArray(node.left, &array)
      fillLeafArray(node.right, &array)
    }
  }
  
  /*
   Question Leetcode 515: Find Largest Value in Each Tree Row
   */
  var levelMax: [Int: Int] = [:]
  func largestValues(_ root: TreeNode?) -> [Int] {
    findLargestValues(root, 0)
    var answer: [Int] = []
    var pointer = 0
    while let value = levelMax[pointer] {
      answer.append(value)
      pointer += 1
    }
    return answer
  }
  
  private func findLargestValues(_ root: TreeNode?, _ level: Int) {
    guard let node = root else { return }
    var val = node.val
    if let maxVal = levelMax[level] {
      levelMax[level] = max(maxVal, val)
    } else {
      levelMax[level] = val
    }
    findLargestValues(node.left, level + 1)
    findLargestValues(node.right, level + 1)
  }
  
  /*
   Leetcode 105: Construct Binary Tree from Preorder and Inorder Traversal
   Approach:
   The 1st node in preorder is the root of the tree.
   Find the idx of the root in inorder array.
   All the elements to the left are part of left subtree and on right are part of right subtree.
   recursively build the left and right subtrees.
   */
  func buildTreeFromInorderAndPreorder(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
    var length = inorder.count
    var hashMap = [Int:Int]()
    for (i, val) in inorder.enumerated() {
      hashMap[val] = i
    }
    
    var preOrderIndex = 0
    
    func buildTreeHelper(_ left: Int, _ right: Int) -> TreeNode? {
      if left > right {
        return nil
      }
      var val = preorder[preOrderIndex]
      var node = TreeNode(val)
      preOrderIndex += 1
      
      var inorderIdx = hashMap[val]!
      
      node.left = buildTreeHelper(left, inorderIdx - 1)
      node.right = buildTreeHelper(inorderIdx + 1, right)
      
      return node
    }
    var end = length - 1
    var root = buildTreeHelper(0, end)
    return root
  }
  
  /*
   Leetcode 126: Construct Binary Tree from Inorder and Postorder Traversal
   */
  func buildTreeFromInorderAndPostOrder(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
    //We know lastIndex of postOreder is root
    var length = postorder.count
    var hashMap = [Int: Int]()
    for (i, val) in inorder.enumerated() {
      hashMap[val] = i
    }
    
    var postorderIdx = length - 1
    
    func buildTreeHelper(_ left: Int, _ right: Int) -> TreeNode? {
      if left > right {
        return nil
      }
      
      var val = postorder[postorderIdx]
      var node = TreeNode(val)
      var inorderIdx = hashMap[val]!
      postorderIdx -= 1
      
      node.right = buildTreeHelper(inorderIdx + 1, right)
      node.left = buildTreeHelper(left, inorderIdx - 1)
      
      return node
    }
    
    return buildTreeHelper(0, length - 1)
  }
  
  /*
   Leetcode 124: Binary Tree Maximum Path Sum
   maxSumPath: maximum sum of any path in the tree
   maxSumPart: maximum sum of any path that can be extended to parent node
   */
  func maxPathSum(_ root: TreeNode?) -> Int {
    guard let node = root else { return 0 }
    
    func maxPathSumHelper(_ node: TreeNode?) -> (maxSum: Int, maxPart: Int) {
      guard let node = node else { return (Int.min, 0) }
      
      let (leftSum, leftPart) = maxPathSumHelper(node.left)
      let (rightSum, rightPart) = maxPathSumHelper(node.right)
      
      // Best path through current node (as the peak)
      let fullPath = leftPart + rightPart + node.val
      // Best single branch (used for parent's fullPath)
      let singleBranch = max(0, max(leftPart, rightPart) + node.val)
      // Global max could be left subtree, right subtree, or current path
      let currentMax = max(fullPath, max(leftSum, rightSum))
      return (currentMax, singleBranch)
    }
    
    let (globalMax, _) = maxPathSumHelper(node)
    return globalMax
  }
  
  /*
   Leetcode 297: Serialize and Deserialize Binary Tree
   Very Important Question
   */
  func serialize(_ root: TreeNode?) -> String {
    var queue: [TreeNode?] = [root]
    var result = [String]()
    
    while !queue.isEmpty {
      let node = queue.removeFirst()
      if let node = node {
        result.append("\(node.val)")
        queue.append(node.left)
        queue.append(node.right)
      } else {
        result.append("#")
      }
    }
    return result.joined(separator: ",")
  }
  
  func deserialize(_ data: String) -> TreeNode? {
    let nodes = data.split(separator: ",").map { String($0) }
    guard !nodes.isEmpty, nodes[0] != "#" else { return nil }
    
    let root = TreeNode(Int(nodes[0])!)
    var queue: [TreeNode] = [root]
    var i = 1
    
    while !queue.isEmpty && i < nodes.count {
      let current = queue.removeFirst()
      
      // Left child
      if i < nodes.count, nodes[i] != "#" {
        let leftNode = TreeNode(Int(nodes[i])!)
        current.left = leftNode
        queue.append(leftNode)
      }
      i += 1
      
      // Right child
      if i < nodes.count, nodes[i] != "#" {
        let rightNode = TreeNode(Int(nodes[i])!)
        current.right = rightNode
        queue.append(rightNode)
      }
      i += 1
    }
    return root
  }
  
  /*
   Leetcode 863: All Nodes Distance K in Binary Tree
   Approach:
   1. Store the parent of each node in a dictionary using any traversal (inorder, postorder, levelorder(preferred)).
   2. Perform a BFS (graph) starting from the target node and store the values which are at distance K.
   */
  func distanceK(_ root: TreeNode?, _ target: TreeNode?, _ k: Int) -> [Int] {
    guard let node = root, let target = target else { return array }
    
    //Store parent in a hashmap using any traversal, I am going to use level order traversal
    var queue: [TreeNode] = []
    var hashMap: [TreeNode: TreeNode] = [:]
    queue.append(node)
    
    while !queue.isEmpty {
      var poppedNode = queue.removeFirst()
      var left = poppedNode.left
      var right = poppedNode.right
      
      if let left = left {
        hashMap[left] = poppedNode
        queue.append(left)
      }
      if let right = right {
        hashMap[right] = poppedNode
        queue.append(right)
      }
    }
    
    var visited = Set<TreeNode>()
    var queue2: [(TreeNode, Int)] = []
    var dist = k
    queue2.append((target, dist))
    while !queue2.isEmpty {
      //Remove
      var popped = queue2.removeFirst()
      var node = popped.0
      var dist = popped.1
      //Check Visited
      if visited.contains(node) {
        continue
      }
      //Mark Visited
      visited.insert(node)
      //Work
      if dist == 0 {
        array.append(node.val)
      }
      dist -= 1
      //Add ngr
      if let left = node.left {
        queue2.append((left, dist))
      }
      if let right = node.right {
        queue2.append((right, dist))
      }
      if let parent = hashMap[node] {
        queue2.append((parent, dist))
      }
    }
    return array
  }
  
  /*
   Leetcode 236: Lowest Common Ancestor of a Binary Tree
   */
  class Solution {
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
      guard let root = root, let p = p, let q = q else { return nil }
      
      var pathP: [TreeNode] = []
      var pathQ: [TreeNode] = []
      
      func findPath(_ node: TreeNode?, _ target: TreeNode, _ path: inout [TreeNode]) -> Bool {
        guard let node = node else { return false }
        
        if node === target {
          path.append(node)
          return true
        }
        
        if findPath(node.left, target, &path) || findPath(node.right, target, &path) {
          path.append(node)
          return true
        }
        
        return false
      }
      
      _ = findPath(root, p, &pathP)
      _ = findPath(root, q, &pathQ)
      
      let revP = Array(pathP.reversed())
      let revQ = Array(pathQ.reversed())
      
      var i = 0
      while i < revP.count, i < revQ.count, revP[i] === revQ[i] {
        i += 1
      }
      return i > 0 ? revP[i - 1] : nil
    }
  }
  
  /*
   Leetcode 113: Path Sum II
   */
  func pathSum(_ root: TreeNode?, _ targetSum: Int) -> [[Int]] {
    var array: [[Int]] = []
    var subArray: [Int] = []
    
    func calculatePathSum(_ root: TreeNode?, _ target: Int, _ sum: Int, _ subAns: inout [Int]) {
      guard let node = root else { return }
      var val = node.val
      var sum = sum
      
      sum += val
      
      if sum == target && node.left == nil && node.right == nil {
        var newSub = subAns
        newSub.append(val)
        array.append(newSub)
      }
      subAns.append(val)
      calculatePathSum(node.left, target, sum, &subAns)
      calculatePathSum(node.right, target, sum, &subAns)
      subAns.popLast()
    }
    
    calculatePathSum(root, targetSum, 0, &subArray)
    return array
  }
  
  /*
   Leetcode 437: Path Sum III
   You need two separate recursive functions:
   dfs(node) → tries every node as a starting point
   countPaths(node, runningSum) → counts how many paths from that node add to target
   
   Very Important Question
   */
  func pathSum(_ root: TreeNode?, _ targetSum: Int) -> Int {
    guard let root = root else { return 0 }
    
    return countFrom(root, targetSum)
    + pathSum(root.left, targetSum)
    + pathSum(root.right, targetSum)
    
    func countFrom(_ node: TreeNode?, _ remaining: Int) -> Int {
      guard let node = node else { return 0 }
      
      var count = 0
      if node.val == remaining {
        count += 1
      }
      
      count += countFrom(node.left, remaining - node.val)
      count += countFrom(node.right, remaining - node.val)
      return count
    }
  }
  
  /*
   Leetcode 987: Vertical Order Traversal of a Binary Tree
   */
  func verticalTraversal(_ root: TreeNode?) -> [[Int]] {
    var answer: [[Int]] = []
    guard let node = root else { return answer }
    var queue = [(TreeNode, Int, Int)]()
    queue.append((node, 0, 0))
    var hashmap: [Int: [(Int, Int)]] = [:]
    var minIdx = Int.max
    while !queue.isEmpty {
      var popped = queue.removeFirst()
      var removedNode = popped.0
      var val = removedNode.val
      var idx = popped.1
      var yIdx = popped.2
      
      if hashmap[idx] != nil {
        hashmap[idx]!.append((val, yIdx))
      } else {
        var subAns = [(Int, Int)]()
        subAns.append((val, yIdx))
        hashmap[idx] = subAns
      }
      
      if let left = removedNode.left {
        var newIdx = idx - 1
        queue.append((left, newIdx, yIdx + 1))
      }
      
      if let right = removedNode.right {
        var newIdx = idx + 1
        queue.append((right, newIdx, yIdx + 1))
      }
      
      minIdx = min(minIdx, idx)
    }
    
    var pointer = minIdx
    while let subArr = hashmap[pointer] {
      var subArr = subArr.sorted {
        if $0.1 == $1.1 {
          return $0.0 < $1.0
        }
        return $0.1 < $1.1
      }
      var subArrAns = subArr.map { $0.0 }
      answer.append(subArrAns)
      pointer += 1
    }
    return answer
  }
  
  /*
   Leetcode 2246: Longest Path With Different Adjacent Characters
   */
  func longestPath(_ parent: [Int], _ s: String) -> Int {
    class TreeNode {
      var val: Int
      var children: [TreeNode]
      
      init(_ val: Int) {
        self.val = val
        self.children = []
      }
    }

    var length = parent.count
    var hashmap: [Int : TreeNode] = [:]
    hashmap[0] = TreeNode(0)
    var charArray = Array(s)
    
    for i in 0..<length {
      if hashmap[i] == nil {
        hashmap[i] = TreeNode(i)
      }
      let p = parent[i]
      if p != -1 {
        if hashmap[p] == nil {
          hashmap[p] = TreeNode(p)
        }
        hashmap[p]!.children.append(hashmap[i]!)
      }
    }
    
    func dfs(_ node: TreeNode) -> (Int, Int) {
      
      var maxPath = 0
      var maxlength1 = 0
      var maxlength2 = 0
      var nodeVal = node.val
      var nodeChar = charArray[nodeVal]
      for child in node.children {
        
        var val = child.val
        var char = charArray[val]
        
        var (path, length) = dfs(child)
        maxPath = max(maxPath, path)
        
        if nodeChar != char {
          if length >= maxlength1 {
            maxlength2 = maxlength1
            maxlength1 = length
          } else if length >= maxlength2 {
            maxlength2 = length
          }
        }
      }
      
      maxPath = max(maxPath, maxlength1 + maxlength2 + 1)
      
      return (maxPath, maxlength1 + 1)
    }
    
    var (maxPath, _) = dfs(hashmap[0]!)
    return maxPath
  }
}
