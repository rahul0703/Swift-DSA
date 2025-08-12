//
//  PriorityQueueCustom.swift
//  DSA
//
//  Created by Rahul Sureka on 05/08/25.
//

import Foundation
struct PriorityQueueCustom<T: Comparable> {
  private var heap: [T]
  
  init() {
    self.heap = []
  }
  
  var isEmpty: Bool {
    return heap.isEmpty
  }
  
  var count: Int {
    return heap.count
  }
  
  func peek() -> T? {
    return heap.first
  }
  
  mutating func push(_ element: T) {
    heap.append(element)
    siftUp(from: heap.count - 1)
  }
  
  mutating func pop() -> T? {
    guard !heap.isEmpty else { return nil }
    if heap.count == 1 {
      return heap.removeFirst()
    }
    
    let top = heap[0]
    heap[0] = heap.removeLast()
    siftDown(from: 0)
    return top
  }
  
  private mutating func siftUp(from index: Int) {
    var child = index
    var parent = (child - 1) / 2
    
    while child > 0 && heap[child] < heap[parent] {
      heap.swapAt(child, parent)
      child = parent
      parent = (child - 1) / 2
    }
  }
  
  private mutating func siftDown(from index: Int) {
    var parent = index
    let count = heap.count
    
    while true {
      let left = 2 * parent + 1
      let right = 2 * parent + 2
      var candidate = parent
      
      if left < count && heap[left] < heap[candidate] {
        candidate = left
      }
      if right < count && heap[right] < heap[candidate] {
        candidate = right
      }
      
      if candidate == parent { break }
      
      heap.swapAt(parent, candidate)
      parent = candidate
    }
  }
}


struct PriorityQueueCustom<T> {
  private var elements: [T] = []
  private let areInIncreasingOrder: (T, T) -> Bool
  
  init(sort: @escaping (T, T) -> Bool) {
    self.areInIncreasingOrder = sort
  }
  
  mutating func push(_ value: T) {
    elements.append(value)
    elements.sort(by: areInIncreasingOrder)
  }
  
  mutating func pop() -> T? {
    return elements.isEmpty ? nil : elements.removeFirst()
  }
  
  func isEmpty() -> Bool {
    return elements.isEmpty
  }
}

