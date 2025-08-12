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
  
}
