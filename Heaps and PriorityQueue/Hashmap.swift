//
//  Hashmap.swift
//  DSA
//
//  Created by Rahul Sureka on 28/08/25.
//


class Hashmap {
  struct Price {
      let timestamp: Int
      let value: Int
  }

  class PriorityQueue<T> {
    private var elements: [T] = []
    private let sortingOrder: (T, T) -> Bool

    init(_ order: @escaping (T, T) -> Bool) {
      self.sortingOrder = order
    }

    var size: Int {
      return elements.count
    }

    var isEmpty: Bool {
      return elements.isEmpty
    }

    func push(_ element: T) {
      elements.append(element)
      elements.sort(by: sortingOrder)
    }

    func remove() -> T? {
      return elements.isEmpty ? nil : elements.removeFirst()
    }

    func peek() -> T? {
      return elements.first
    }
  }

  //Question: 239. Sliding Window Maximum
  func maxStockPricesInWindow(_ prices: [Price], _ k: Int) -> [Int] {
      var result = [Int]()
      var pq = PriorityQueue<Price> { $0.value > $1.value }
      var i = 0
      let n = prices.count

      for price in prices {
          // Remove expired prices
          while let top = pq.peek(), top.timestamp < price.timestamp - k + 1 {
              _ = pq.pop()
          }

          pq.push(price)
          if let top = pq.peek() {
              result.append(top.value)
          }
      }

      return result
  }
  
  //Question: 239. Sliding Window Maximum - For every timestamp from start to end
  func maxStockPricesInWindow(_ prices: [Price], _ k: Int) -> [Int] {
      var result = [Int]()
      var i = 0
      let n = prices.count
      var currentTime = prices.first?.timestamp ?? 0

      var pq = PriorityQueue<Price> { $0.value > $1.value }

      // Fill first window (from currentTime to currentTime + k - 1)
      while i < n && prices[i].timestamp <= currentTime + k - 1 {
          pq.push(prices[i])
          i += 1
      }

      if let top = pq.peek() {
          result.append(top.value)
      }

      currentTime += 1

      while i < n {
          // Remove expired entries
          while let top = pq.peek(), top.timestamp < currentTime - k + 1 {
              _ = pq.pop()
          }

          // Add all prices that come at this timestamp
          if prices[i].timestamp == currentTime {
              pq.push(prices[i])
              i += 1
          }

          // Append current max
          if let top = pq.peek() {
              result.append(top.value)
          } else {
              result.append(0)
          }

          currentTime += 1
      }

      return result
  }

}
