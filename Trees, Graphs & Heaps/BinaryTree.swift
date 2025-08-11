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
   Leetcode
   */
}
