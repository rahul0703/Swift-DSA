//
//  LRUCache.swift
//  DSA
//
//  Created by Rahul Sureka on 10/08/25.
//

import Foundation

class LRUCache {
  
  class Node {
    let key: Int
    var value: Int
    var prev: Node?
    var next: Node?
    
    init(_ key: Int, _ value: Int) {
      self.key = key
      self.value = value
    }
  }
  
  private var cache: [Int: Node] = [:]
  private let capacity: Int
  private let head = Node(0, 0)  // Dummy head
  private let tail = Node(0, 0)  // Dummy tail
  
  init(_ capacity: Int) {
    self.capacity = capacity
    head.next = tail
    tail.prev = head
  }
  
  func get(_ key: Int) -> Int {
    if let node = cache[key] {
      moveToHead(node)
      return node.value
    } else {
      return -1
    }
  }
  
  func put(_ key: Int, _ value: Int) {
    if let node = cache[key] {
      node.value = value
      moveToHead(node)
    } else {
      let newNode = Node(key, value)
      cache[key] = newNode
      addToHead(newNode)
      
      if cache.count > capacity {
        if let lru = removeTail() {
          cache.removeValue(forKey: lru.key)
        }
      }
    }
  }
  
  // MARK: - Doubly Linked List Helpers
  
  private func addToHead(_ node: Node) {
    node.prev = head
    node.next = head.next
    head.next?.prev = node
    head.next = node
  }
  
  private func removeNode(_ node: Node) {
    node.prev?.next = node.next
    node.next?.prev = node.prev
  }
  
  private func moveToHead(_ node: Node) {
    removeNode(node)
    addToHead(node)
  }
  
  private func removeTail() -> Node? {
    guard let node = tail.prev, node !== head else { return nil }
    removeNode(node)
    return node
  }
}

