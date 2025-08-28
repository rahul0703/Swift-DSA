

class HashMap<K: Hashable, V> {
  // A single key-value pair
  private typealias Entry = (key: K, value: V)
  
  // Array of buckets (each bucket is an array of entries, to handle collisions)
  private var buckets: [[Entry]]
  
  // Current capacity (number of buckets)
  private var capacity: Int
  
  // Number of key-value pairs stored
  private(set) var count: Int = 0
  
  // Threshold to trigger resizing (e.g. 75% full)
  private let loadFactor: Double = 0.75
  
  // Initialize with default capacity (can be passed too)
  init(initialCapacity: Int = 16) {
    self.capacity = initialCapacity
    self.buckets = Array(repeating: [], count: capacity)
  }
  
  // Insert or update a value
  func put(_ key: K, _ value: V) {
    let index = bucketIndex(for: key)  // Determine the correct bucket
    
    // Check if key already exists — if so, update value
    for i in 0..<buckets[index].count {
      if buckets[index][i].key == key {
        buckets[index][i].value = value
        return  // Update done
      }
    }
    
    // Key not found — insert new entry
    buckets[index].append((key, value))
    count += 1
    
    // If load factor exceeded, double the size
    if Double(count) / Double(capacity) > loadFactor {
      resize()
    }
  }
  
  // Retrieve value by key
  func get(_ key: K) -> V? {
    let index = bucketIndex(for: key)
    
    // Search for key in bucket
    for entry in buckets[index] {
      if entry.key == key {
        return entry.value  // Found
      }
    }
    
    return nil  // Not found
  }
  
  // Remove key-value pair if present
  func remove(_ key: K) {
    let index = bucketIndex(for: key)
    
    // Remove all matches of the key from the bucket
    buckets[index].removeAll { $0.key == key }
    count -= 1
  }
  
  // Check if key exists
  func containsKey(_ key: K) -> Bool {
    return get(key) != nil
  }
  
  // Convert hash value to a valid bucket index
  private func bucketIndex(for key: K) -> Int {
    return abs(key.hashValue) % capacity
  }
  
  // Resize buckets when load factor is exceeded
  private func resize() {
    let oldBuckets = buckets  // Save old entries
    
    capacity *= 2  // Double capacity
    buckets = Array(repeating: [], count: capacity)  // Create new, empty buckets
    count = 0  // Reset count — will re-add everything
    
    // Re-insert all entries to new buckets
    for bucket in oldBuckets {
      for entry in bucket {
        put(entry.key, entry.value)  // Re-hashing required!
      }
    }
  }
}

