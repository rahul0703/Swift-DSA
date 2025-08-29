//
//  GenricTree.swift
//  DSA
//
//  Created by Rahul Sureka on 10/08/25.
//

import Foundation

class GenricTree {
  /*
   Classes
   */
  public class Node {
    public var val: Int
    public var children: [Node]
    public init(_ val: Int) {
      self.val = val
      self.children = []
    }
  }
  
  /*
   Question leetoce 589: N-ary Tree Preorder Traversal
   */
  func preorder(_ root: Node?) -> [Int] {
    if root == nil {
      return []
    }
    var array: [Int] = []
    fillPreorder(root, &array)
    return array
  }
  
  func fillPreorder(_ root: Node?, _ array: inout [Int]) {
    guard let node = root else { return }
    array.append(node.val)
    for child in node.children {
      fillPreorder(child, &array)
    }
  }
  
  /*
   Question leetoce 590: N-ary Tree Postorder Traversal
   */
  func postorder(_ root: Node?) -> [Int] {
    if root == nil {
      return []
    }
    var array: [Int] = []
    fillPostorder(root, &array)
    return array
  }
  
  func fillPostorder(_ root: Node?, _ array: inout [Int]) {
    guard let node = root else { return }
    for child in node.children {
      fillPostorder(child, &array)
    }
    array.append(node.val)
  }
  
  /*
   Question Leetcode 582: Kill Process (Process Tree) ✅ Google tag
   Desc: You have n processes forming a rooted tree structure. You are given two integer arrays pid and ppid, where pid[i] is the ID of the ith process and ppid[i] is the ID of the ith process's parent process. The only process that has no parent process is the root process, whose ppid is 0. Each process can have multiple children processes, but no process can be its own ancestor. You are also given an integer kill, which is the ID of a process you want to kill. When a process is killed, all of its children processes should
   */
  func killProcess(_ pid: [Int], _ ppid: [Int], _ kill: Int) -> [Int] {
    var map = [Int: Node]()
    // Create nodes
    for id in pid {
      map[id] = Node(id)
    }
    // Build tree structure
    for i in 0..<pid.count {
      let parentId = ppid[i]
      if parentId != 0 {
        map[parentId]?.children.append(map[pid[i]]!)
      }
    }
    // DFS to collect killed processes
    var result = [Int]()
    killAllProcesses(map[kill], &result)
    return result
  }
  
  private func killAllProcesses(_ node: Node?, _ result: inout [Int]) {
    guard let node = node else { return }
    result.append(node.val)
    for child in node.children {
      killAllProcesses(child, &result)
    }
  }
  
  /*
   Leetcode 1110: Delete Nodes And Return Forest
   important question
   */
  var deleteNodeArray: [TreeNode?] = []
  func delNodes(_ root: TreeNode?, _ to_delete: [Int]) -> [TreeNode?] {
    var hashSet = Set<Int>()
    for num in to_delete {
      hashSet.insert(num)
    }
    deleteNode(root, nil, hashSet)
    if let val = root?.val {
      if !hashSet.contains(val) {
        deleteNodeArray.append(root)
      }
    }
    return deleteNodeArray
  }
  
  private func deleteNode(_ root: TreeNode?, _ parent: TreeNode?, _ hashSet: Set<Int>) {
    guard let node = root else { return }
    deleteNode(node.left, node, hashSet)
    deleteNode(node.right, node, hashSet)
    
    var val = node.val
    if hashSet.contains(val) {
      if parent != nil {
        if parent?.left === root {
          parent?.left = nil
        } else {
          parent?.right = nil
        }
      }
      if node.left != nil {
        deleteNodeArray.append(node.left)
      }
      if node.right != nil {
        deleteNodeArray.append(node.right)
      }
    }
  }
}
