//
//  GenricTree.swift
//  DSA
//
//  Created by Rahul Sureka on 05/08/25.
//

import Foundation

struct TreeNode<T> {
    var value: T
    var children: [TreeNode<T>]
}

class GenericTree {
  /*
   Question 1: Construct a generic tree from eular tour
   */
  func constructTree(from eularTour: [Int]) -> TreeNode<Int>? {
      var stack = [TreeNode<Int>]()
      var len = eularTour.count
      var head: TreeNode<Int>? = nil
      for i in 0 ..< len {
          var value = eularTour[i]
          if value == -1 {
              stack.popLast()
          } else {
              var node = TreeNode(value: value, children: [])
              if stack.isEmpty {
                  stack.append(node)
                  head = node
              } else {
                  var parentNode = stack.popLast()!
                  parentNode.children.append(node)
                  stack.append(parentNode)
                  stack.append(node) // Push the current node onto the stack
              }
          }
      }
      return head
  }

  //Display a genric tree
  func displayTree<T>(node: TreeNode<T>) {
      
  }
}
