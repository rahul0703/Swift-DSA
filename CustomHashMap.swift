//
//  CustomHashMap.swift
//  DSA
//
//  Created by Rahul Sureka on 20/08/25.
//

import Foundation

// Swift 5+
// HashMap with separate chaining using array "lists" per bucket.

public final class HashMap<Key: Hashable, Value> {
  // MARK: - Node (like HMnode in Java)
  private struct HMNode {
    let key: Key
    var value: Value
  }
  
  // MARK: - Storage
  private var buckets: [[HMNode]]
  private(set) public var size: Int = 0
  
  // MARK: - Init
  public init(initialCapacity: Int = 4) {
    precondition(initialCapacity > 0, "Capacity must be > 0")
    self.buckets = Array(repeating: [], count: initialCapacity)
  }
  
  // MARK: - Hashing & bucket helpers
  private func hashFunction(_ key: Key) -> Int {
    // Make hash non-negative and map to a bucket index
    return Int(UInt(bitPattern: key.hashValue) % UInt(buckets.count))
  }
  
  // Returns index within bucket if found, else nil
  private func findWithinBucket(_ bi: Int, _ key: Key) -> Int? {
    for (di, node) in buckets[bi].enumerated() {
      if node.key == key { return di }
    }
    return nil
  }
  
  // MARK: - API (mirrors your Java methods)
  
  public func get(_ key: Key) -> Value? {
    let bi = hashFunction(key)
    if let di = findWithinBucket(bi, key) {
      return buckets[bi][di].value
    }
    return nil
  }
  
  public func put(key: Key, value: Value) {
    let bi = hashFunction(key)
    if let di = findWithinBucket(bi, key) {
      // update
      buckets[bi][di].value = value
    } else {
      // insert
      buckets[bi].append(HMNode(key: key, value: value))
      size += 1
    }
    
    // load factor check (lambda > 2.0) -> rehash
    let lambda = Double(size) / Double(buckets.count)
    if lambda > 2.0 {
      rehash()
    }
  }
  
  public func containsKey(_ key: Key) -> Bool {
    let bi = hashFunction(key)
    return findWithinBucket(bi, key) != nil
  }
  
  @discardableResult
  public func remove(_ key: Key) -> Value? {
    let bi = hashFunction(key)
    guard let di = findWithinBucket(bi, key) else { return nil }
    let removed = buckets[bi].remove(at: di).value
    size -= 1
    return removed
  }
  
  // MARK: - Rehash (double bucket count)
  private func rehash() {
    let oldBuckets = buckets
    buckets = Array(repeating: [], count: max(1, oldBuckets.count * 2))
    size = 0
    
    for bucket in oldBuckets {
      for node in bucket {
        put(key: node.key, value: node.value)
      }
    }
  }
  
  // MARK: - Utilities (like display, size, isEmpty, keySet)
  public func display() {
    print("``````````````````````````````````")
    for i in 0..<buckets.count {
      let items = buckets[i].map { "{\($0.key)=\($0.value)}" }.joined(separator: ", ")
      print("B\(i)- \(items)")
    }
  }
  
  public func isEmpty() -> Bool { size == 0 }
  
  public func keySet() -> [Key] {
    var keys: [Key] = []
    keys.reserveCapacity(size)
    for bucket in buckets {
      for node in bucket { keys.append(node.key) }
    }
    return keys
  }
}

