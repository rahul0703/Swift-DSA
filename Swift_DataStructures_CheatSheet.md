# 📄 Swift Built-in Methods for DSA Cheat Sheet (Complete)

---

## 1. String in Swift

```swift
let str = "hello"
```

| Syntax | Description | Time Complexity |
|--------|-------------|-----------------|
| `str.count` | Number of characters | O(1) |
| `str.isEmpty` | Check if empty | O(1) |
| `str.hasPrefix("he")` / `str.hasSuffix("lo")` | Check for prefix/suffix | O(k) |
| `str.lowercased()` / `uppercased()` | Convert case | O(n) |
| `str.reversed()` | Returns reversed collection | O(n) |
| `String(str.reversed())` | Reversed string | O(n) |
| `str.dropFirst(n)` / `dropLast(n)` | Remove n chars from start/end | O(n) |
| `str.prefix(n)` / `suffix(n)` | Get first/last n characters | O(k) |
| `str.index(str.startIndex, offsetBy: n)` | Get index offset | O(1) |
| `str[str.index(...)]` | Access character by index | O(1) |
| `str.replacingOccurrences(of: "a", with: "b")` | Replace substring | O(n) |
| `str.components(separatedBy: " ")` | Split by separator | O(n) |
| `str.split(separator: ",")` | Split by character and omit empty strings | O(n) |
| `str.contains("el")` | Substring search | O(n) |
| `str.filter { $0 != "a" }` | Filter characters | O(n) |
| `str.map { $0.uppercased() }` | Transform characters | O(n) |
| `str.sorted()` | Sort characters | O(n log n) |

---

## 2. Array in Swift

```swift
var arr = [1, 2, 3]
```

| Syntax | Description | Time Complexity |
|--------|-------------|-----------------|
| `arr.count` | Number of elements | O(1) |
| `arr.isEmpty` | Check if empty | O(1) |
| `arr.append(x)` | Add to end | O(1) amortized |
| `arr.insert(x, at: i)` | Insert at index | O(n) |
| `arr.remove(at: i)` | Remove by index | O(n) |
| `arr.popLast()` / `removeLast()` | Remove last element | O(1) |
| `arr.first` / `last` | Access first/last element | O(1) |
| `arr.reverse()` / `arr.reversed()` | Reverse in-place / new reversed array | O(n) |
| `arr.sort()` / `arr.sorted()` | Sort in-place / new sorted array | O(n log n) |
| `arr.contains(x)` | Search for element | O(n) |
| `arr.enumerated()` | Get index + value pair | O(n) |
| `arr.prefix(n)` / `suffix(n)` | Slice of first/last n elements | O(k) |
| `arr.dropFirst(n)` / `dropLast(n)` | Drop elements from start/end | O(n) |
| `arr.map { $0 * 2 }` | Transform each element | O(n) |
| `arr.filter { $0 % 2 == 0 }` | Keep elements matching condition | O(n) |
| `arr.reduce(0, +)` | Sum of elements | O(n) |
| `arr.removeAll()` | Clear array | O(n) |
| `arr.joined()` | Join strings in array | O(n) |
| `arr.swapAt(i, j)` | Swap values at indices | O(1) |
| `arr.index(of: x)` | Index of first occurrence | O(n) |
| `arr.min()` / `max()` | Min/max values | O(n) |

---

## 3. Stack in Swift (Using Array)

```swift
var stack = [Int]()
```

| Syntax | Description | Time Complexity |
|--------|-------------|-----------------|
| `stack.append(x)` | Pushes an element | O(1) |
| `stack.popLast()` | Pops top element | O(1) |
| `stack.last` | Peeks top element | O(1) |
| `stack.isEmpty` | Checks if stack is empty | O(1) |

---

## 4. Queue in Swift (Using Array)

```swift
var queue = [Int]()
```

| Syntax | Description | Time Complexity |
|--------|-------------|-----------------|
| `queue.append(x)` | Enqueue | O(1) |
| `queue.removeFirst()` | Dequeue | O(n) |
| `queue.first` | Peek front | O(1) |
| `queue.isEmpty` | Check if empty | O(1) |

---

## 5. Set in Swift

```swift
var s: Set<Int> = [1, 2, 3]
```

| Syntax | Description | Time Complexity |
|--------|-------------|-----------------|
| `s.insert(x)` | Add element | O(1) |
| `s.contains(x)` | Check presence | O(1) |
| `s.remove(x)` | Remove element | O(1) |
| `s.union(Set)` | Combine sets | O(n) |
| `s.intersection(Set)` | Common elements | O(n) |
| `s.subtracting(Set)` | Difference | O(n) |
| `s.isSubset(of:)` / `isSuperset(of:)` | Set relation checks | O(n) |
| `s.isEmpty` / `s.count` | Status checks | O(1) |
| `s.sorted()` | Sorted version | O(n log n) |
| `s.forEach { ... }` | Iterate | O(n) |

---

## 6. Dictionary in Swift

```swift
var dict = ["a": 1, "b": 2]
```

| Syntax | Description | Time Complexity |
|--------|-------------|-----------------|
| `dict["a"]` | Access value | O(1) |
| `dict["a"] = nil` | Remove key | O(1) |
| `dict.keys` / `dict.values` | Get keys/values | O(n) |
| `dict.updateValue(3, forKey: "a")` | Update value | O(1) |
| `dict.removeValue(forKey: "a")` | Remove by key | O(1) |
| `dict.contains { $0.key == "a" }` | Check key (slower) | O(n) |
| `dict.isEmpty` / `dict.count` | Status checks | O(1) |
| `for (k, v) in dict` | Iterate key-values | O(n) |
| `dict.mapValues { $0 * 2 }` | Transform values | O(n) |
| `dict.merge(otherDict) { (_, new) in new }` | Combine dictionaries | O(n) |
| `dict.filter { $0.value > 10 }` | Filter pairs | O(n) |

---

## 7. Tuple in Swift

```swift
let t = (1, "a")
```

| Syntax | Description | Time Complexity |
|--------|-------------|-----------------|
| `t.0` | First element | O(1) |
| `t.1` | Second element | O(1) |

---

## 8. Comparable and Comparator in Swift

### Conforming to `Comparable`

```swift
struct Person: Comparable {
    let name: String
    let age: Int
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.age < rhs.age
    }
}
```

| Syntax | Description | Time Complexity |
|--------|-------------|-----------------|
| `static func <` | Defines less-than logic | O(1) |
| `==` | Equatable conformance | O(1) |
| `array.sort()` | Uses `<` for sorting | O(n log n) |

### Using `sort(by:)` for Custom Comparators

```swift
let nums = [5, 3, 8]
let sorted = nums.sorted(by: { $0 > $1 })
```

| Syntax | Description | Time Complexity |
|--------|-------------|-----------------|
| `sorted(by: <)` | Sorts using custom logic | O(n log n) |
| `{ $0.property < $1.property }` | Custom comparator | O(1) per comparison |
| `array.sorted()` | Sorts based on `Comparable` | O(n log n) |

---


# Swift Collections – Deque and Heap Reference

This document outlines the key methods of `Deque` and `Heap` from [Swift Collections](https://github.com/apple/swift-collections).

---

## 📦 `Deque<T>` — Double-Ended Queue

A **random-access, double-ended queue**, similar to Java’s `ArrayDeque`.

### ✅ Initialization
```swift
var deque = Deque<Int>()
var dequeWithArray = Deque([1, 2, 3])
```

### 🔁 Insertion Methods
```swift
deque.append(1)                       // Add to back
deque.append(contentsOf: [2, 3])     
deque.prepend(0)                      // Add to front
```

### ❌ Removal Methods
```swift
Gives non optional values, so ensure deque is not empty before calling.
let last = deque.removeLast()         // O(1)
let first = deque.removeFirst()       // O(1)
```

### 👀 Peek Methods
```swift
Give optional values.
let front = deque.first
let back = deque.last
```

### 🔁 Other Utilities
```swift
deque.count
deque.isEmpty
deque.reverse()
deque.sort()
```

### 📝 Notes
- Supports array-style indexing: `deque[2]`
- Conforms to `Collection`, `RandomAccessCollection`

---

## 📦 `Heap<T>` — Binary Heap / Priority Queue (Swift Collections)

Implements a binary heap that acts as a min-heap or max-heap depending on the comparator.

### ✅ Initialization

```swift
import Collections

var minHeap = Heap<Int>(sortedBy: <)   // Min-heap
var maxHeap = Heap<Int>(sortedBy: >)   // Max-heap

var heapFromArray = Heap([3, 1, 5], sortedBy: <)
```

### ➕ Insertion

```swift
heap.insert(4)
```

### ✅ Removal (Safe, Optional)

```swift
let smallest = heap.popMin()   // For min-heap → returns T?
let largest = heap.popMax()    // For max-heap → returns T?
```

> These methods return `nil` if the heap is empty — safe and non-crashing.

### 👀 Peek (Non-destructive)

```swift
let top = heap.peek()   // Returns T? — top element (min or max)
```

### 🛠 Other Utilities

```swift
heap.count
heap.isEmpty
```

### 🔄 Mutation (Advanced)

```swift
heap.replace(at: index, with: newValue)
heap.remove(at: index)
```

> These are useful for in-place updates (e.g. Dijkstra, A*) but rarely used in basic heap problems.

### 🧠 Notes

- There is **no `remove()` or `pop()`** method — use `popMin()` or `popMax()`.
- `Heap` is a **value type** (`struct`)
- Does **not** support key-priority updates directly — remove and reinsert instead.

---

## ✅ Summary Table

| Data Structure | Method                                | Description                  |
|----------------|---------------------------------------|------------------------------|
| `Deque`        | `append(_:)`, `prepend(_:)`           | Add to back / front          |
|                | `removeFirst()`, `removeLast()`       | Remove from front / back     |
|                | `first`, `last`                       | Peek at front / back         |
|                | `isEmpty`, `count`, `reverse()`, `sort()` | Utility methods              |
| `Heap`         | `insert(_:)`                          | Insert element               |
|                | `remove()`                            | Remove root (min or max)     |
|                | `peek()`                              | Peek at root                 |
|                | `count`, `isEmpty`                    | Utility methods              |
|                | `replace(at:with:)`, `remove(at:)`    | Mutation at index (advanced) |

---

## 📌 Importing the Library

Install via Swift Package Manager:

```text
https://github.com/apple/swift-collections
```

Import in your file:

```swift
import Collections
```

---

## 🧠 Interview Tip

> Swift doesn’t include these in the standard library. If asked not to use libraries, implement custom versions from scratch (heap, deque using 2 stacks or linked list).

## 🔗 Notes

- Time complexities are approximated for typical use cases.
- Some operations (like `removeFirst()` in Array) are slower due to internal memory shifts.
- Use `Deque` from `Swift Collections` package for O(1) front and back operations.

