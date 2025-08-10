//
//  DoublyLinkedList.swift
//  DSA
//
//  Created by Rahul Sureka on 10/08/25.
//

import Foundation

class DoublyLinkedList {
  private class Node {
    public var val: Int
    public var prev: Node?
    public var next: Node?
    public var child: Node?
    public init(_ val: Int) {
      self.val = val
      self.prev = nil
      self.next = nil
      self.child  = nil
    }
  }
  func flatten(_ head: Node?) -> Node? {
    if head == nil {
      return nil
    }
    
    var point = head
    while point != nil {
      if point?.child != nil {
        var childHead = flatten(point?.child)
        var lastNode = findLast(childHead)
        var next = point?.next
        point?.next = childHead
        childHead?.prev = point
        point?.child = nil
        lastNode?.next = next
        next?.prev = lastNode
        point = next
      } else {
        point = point?.next
      }
    }
    return head
  }
  
  func findLast(_ head: Node?) -> Node? {
    var pointer = head
    if head == nil || head?.next == nil {
      return head
    }
    while pointer?.next != nil {
      pointer = pointer?.next
    }
    return pointer
  }
}
