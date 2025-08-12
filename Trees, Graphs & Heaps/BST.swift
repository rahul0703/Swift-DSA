//
//  BST.swift
//  DSA
//
//  Created by Rahul Sureka on 12/08/25.
//

import Foundation

class BST {
  /*
   Leetcode 98: Validate Binary Search Tree
   */
  func isValidBST(_ root: TreeNode?) -> Bool {
    if root == nil {
      return true
    }
    
    var (max, min, subAnswer) = checkValidBST(root)
    return subAnswer
  }
  
  private func checkValidBST(_ node: TreeNode?) -> (Int, Int, Bool) {
    guard let node = node else  {
      return (Int.min, Int.max, true)
    }
    var (maxLeft, minLeft, answerLeft) = checkValidBST(node.left)
    var (maxRight, minRight, answerRight) = checkValidBST(node.right)
    
    var val = node.val
    
    if answerLeft && answerRight && val > maxLeft && val < minRight {
      var maxValue = max(val, maxRight)
      var minValue = min(val, minLeft)
      return (maxValue, minValue, true)
    }
    return (0, 0, false)
  }
  
  /*
   Leetcode 701: Insert into a Binary Search Tree
   */
  func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
    guard let node = root else { return TreeNode(val) }
    var nodeVal = node.val
    
    if nodeVal > val {
      root?.left = insertIntoBST(node.left, val)
    } else if nodeVal < val {
      root?.right = insertIntoBST(node.right, val)
    }
    return root
  }
  
  /*
   Leetcode 450: Delete Node in a BST
   Approach:
   1. find the node to be deleated
   2. If the node is leaf, return nil
   3. If the node has only one child, return that child
   4. If the node has 2 childre, find the left max and replace the node value with that max value
   and recursively delete that max value from the left subtree
   */
  func deleteNode(_ root: TreeNode?, _ key: Int) -> TreeNode? {
    if root == nil {
      return nil
    }
    
    guard let val = root?.val else { return nil }
    if key < val {
      root?.left = deleteNode(root?.left, key)
    } else if key > val {
      root?.right = deleteNode(root?.right, key)
    } else {
      if root?.left == nil && root?.right == nil {
        return nil
      } else if root?.left == nil {
        return root?.right
      } else if root?.right == nil {
        return root?.left
      } else {
        var maxLeft = findMax(root?.left)
        root?.val = maxLeft
        root?.left = deleteNode(root?.left, maxLeft)
      }
    }
    return root
  }
  
  func findMax(_ root: TreeNode?) -> Int {
    if root == nil {
      return Int.min
    }
    guard let value = root?.val else { return Int.min }
    return max(findMax(root?.left), max(findMax(root?.right), value))
  }
  
  /*
   Leetcode 235: Lowest Common Ancestor of a Binary Search Tree
   */
  func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
    guard let node = root, let child1 = p, let child2 = q else { return nil }
    var rootVal = node.val
    var child1Val = child1.val
    var child2Val = child2.val
    
    if child1Val > child2Val {
      return lowestCommonAncestor(root, q, p)
    }
    if rootVal >= child1Val && rootVal <= child2Val {
      return root
    } else if rootVal > child1Val && rootVal > child2Val {
      return lowestCommonAncestor(node.left, p, q)
    } else {
      return lowestCommonAncestor(node.right, p, q)
    }
  }
  
  /*
   Leetcode 669: Trim a Binary Search Tree to stay under [low, high] range
   */
  func trimBST(_ root: TreeNode?, _ low: Int, _ high: Int) -> TreeNode? {
    guard let node = root else { return nil }
    
    var leftNode = removeLeft(node, low)
    var rightNode = removeRight(leftNode, high)
    
    return rightNode
  }
  
  private func removeLeft(_ root: TreeNode?, _ low: Int) -> TreeNode? {
    guard let node = root else { return nil }
    var val = node.val
    
    if val == low {
      root?.left = nil
      return root
    } else if val > low {
      root?.left = removeLeft(node.left, low)
      return root
    } else {
      return removeLeft(node.right, low)
    }
  }
  
  private func removeRight(_ root: TreeNode?, _ high: Int) -> TreeNode? {
    guard let node = root else { return nil }
    var val = node.val
    
    if val == high {
      root?.right = nil
      return root
    } else if val < high {
      root?.right = removeRight(node.right, high)
      return root
    } else {
      return removeRight(node.left, high)
    }
  }
  
  /*
   Leetcode 426: Convert Binary Search Tree to Sorted Doubly Linked List
   */
  func convertBSTToLinkedList(_ root: TreeNode?) -> TreeNode? {
    
  }
}
