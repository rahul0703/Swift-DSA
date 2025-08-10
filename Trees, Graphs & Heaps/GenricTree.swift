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
  
  
}
