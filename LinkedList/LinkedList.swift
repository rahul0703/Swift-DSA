//
//  LinkedList.swift
//  DSA
//
//  Created by Rahul Sureka on 08/08/25.
//

import Foundation

class LinkedListNode<T> {
  var val: Int
  var next: LinkedListNode<T>?
}

class LinkedList {
  func reverseLinkedListUsingRecursion(head: LinkedListNode<Int>?) -> LinkedListNode<Int>? {
    if head == nil || head?.next == nil {
      return head
    }
    var pointer = head
    //Recursive call to reverse the rest of the list
    var newHead = reverseLinkedListUsingRecursion(head: pointer.next)
    
    //Now, head.next point to last node in reversed list
    head.next.next = head
    //Head point to last node, so we set head.next to nil
    head.next = nil
    return newHead
  }
  //-------------------------------------------------------------------------------------------
  /*
   1 -> 2 -> 3 -> 4 -> -> 5 -> nil
   prev = nil
   curr = 1
   next = 2
   
   for 1st iteration
   curr.next = prev,  1-> nil
   prev = curr,  prev = 1
   curr = next,  curr = 2
   for 2nd iteration
   curr.next = prev,  2 -> 1
   prev = curr, prev = 2
   curr = next, curr = 3
   */
  func reverseLinkedListIteratively(head: LinkedListNode<Int>?) -> LinkedListNode<Int>? {
    var curr = head
    var prev = nil
    var next = nil
    while curr != nil {
      next = curr?.next
      curr?.next = prev
      prev = curr
      curr = next
    }
    return prev
  }
  //--------------------------------------------------------------------------------------------------
  /*
   for odd: 1 -> 2 -> 3 -> 4 -> 5 -> nil
   mid when fast.next = nil
   for even: 1 -> 2 -> 3 -> 4 -> nil
   mid when fast.next.next = nil
   */
  func findMiddleOfLinkedList(head: LinkedListNode<Int>?) -> LinkedListNode<Int>? {
    if head == nil || head?.next == nil {
      return head
    }
    var slowPointer = head
    var fastPointer = head
    
    while fastPointer?.next != nil && fastPointer?.next?.next != nil {
      slowPointer = slowPointer?.next
      fastPointer = fastPointer?.next?.next
    }
    return slowPointer
  }
  //--------------------------------------------------------------------------------------------------
  /*
   odd: 1 -> 2 -> 3 -> 4 -> 5 -> nil
   even: 1 -> 2 -> 3 -> 4 -> nil
   for both even and odd, find mid and reverse the linkedlist next to mid.
   */
  func checkIfLinkedListIsPalindrome(head: LinkedListNode<Int>?) -> Bool {
    if head == nil || head?.next == nil {
      return true
    }
    
    var mid = findMiddleOfLinkedList(head: head)
    var reversedHead = reverseLinkedListIteratively(head: mid?.next)
    return checkIfEqual(head, reversedHead)
  }
  //--------------------------------------------------------------------------------------------------
  func checkIfEqual(_ head1: LinkedListNode<Int>?, _ head2: LinkedListNode<Int>?) -> Bool {
    while head1 != nil && head2 != nil {
      if head1?.val != head2?.val {
        return false
      }
      head1 = head1?.next
      head2 = head2?.next
    }
    
    if head1 != nil || head2 != nil {
      return false
    }
    return true
  }
  //--------------------------------------------------------------------------------------------------
  /*
   odd: 1 -> 2 -> 3 -> 4 -> 5 -> nil
   Folded: 1 -> 5 -> 2 -> 4 -> 3 -> nil
   even: 1 -> 2 -> 3 -> 4 -> nil
   folded: 1 -> 4 -> 2 -> 3 -> nil
   
   In both case, we need to find the mid and reverse the linkedlist after mid and merge with 1st half.
   1. Find Mid
   2. Reverse the linkedlist after mid
   3. Merge the two linkedlists
   
   next = pointer1.next
   pointer1.next = pointer2
   pointer2 = pointer2.next
   pointer1 = next
   */
  func foldALinkedList(head: LinkedListNode<Int>?) -> LinkedListNode<Int>? {
    if head == nil || head?.next == nil {
      return head
    }
    var mid = findMiddleOfLinkedList(head: head)
    var reversedHead = reverseLinkedListIteratively(head: mid?.next)
    return mergeLinkedList(head, reversedHead)
  }
  //----------------------------------------------------------------------------------------------
  func mergeLinkedList(_ head1: LinkedListNode<Int>?, _ head2: LinkedListNode<Int>?) -> LinkedListNode<Int>? {
    var pointer1 = head1
    var pointer2 = head2
    var next1 = nil
    var next2 = nil
    while pointer1 != nil && pointer2 != nil {
      next1 = pointer1?.next
      next2 = pointer2?.next
      pointer1?.next = pointer2
      pointer2?.next = next1
      pointer2 = next2
      pointer1 = next1
    }
    
    return head1
  }
  //----------------------------------------------------------------------------------------------
  /*
   Folded odd: 1 -> 5 -> 2 -> 4 -> 3 -> nil
   unfolded: 1 -> 2 -> 3 -> 4 -> 5 -> nil
   folded even: 1 -> 4 -> 2 -> 3 -> nil
   unfolded: 1 -> 2 -> 3 -> 4 -> nil
   
   Here,
   1. Seperate into 2 linkedlist
   2. reverse the second linkedlist
   
   condition, while pointer1.next.next != nil
   */
  func unfoldALinkedList(head: LinkedListNode<Int>?) -> LinkedListNode<Int>? {
    if head == nil || head?.next == nil {
      return head
    }
    var pointer1 = head
    var pointer2 = head?.next
    var head2 = pointer2 // Head of second linkedlist
    
    while pointer1?.next != nil && pointer1?.next?.next != nil {
      var next1 = pointer1?.next?.next
      pointer1?.next = next1
      pointer1 = next1
      
      if next1?.next != nil {
        pointer2?.next = next1?.next
        pointer2 = pointer2?.next
      }
    }
    pointer2?.next = nil // End the second list
    pointer1?.next = reverseLinkedListIteratively(head: head2) // Reverse the second list and attach to first list
    return head
  }
  //----------------------------------------------------------------------------------------------
  /*
   Merge sorting a linked list using recursion.
   */
  func mergeSortLinkedList(head: LinkedListNode<Int>?) -> LinkedListNode<Int>? {
    if head == nil || head?.next == nil {
      return head
    }
    let mid = findMiddleOfLinkedList(head: head)
    let secondHalf = mid?.next
    mid?.next = nil // Split the list
    
    let left = mergeSortLinkedList(head: head)
    let right = mergeSortLinkedList(head: secondHalf)
    return mergeSortedLists(left, right)
  }
  //----------------------------------------------------------------------------------------------
  func mergeSortedLists(_ l1: LinkedListNode<Int>?, _ l2: LinkedListNode<Int>?) -> LinkedListNode<Int>? {
    if l1 == nil { return l2 }
    if l2 == nil { return l1 }
    if l1!.val < l2!.val {
      l1?.next = mergeSortedLists(l1?.next, l2)
      return l1
    } else {
      l2?.next = mergeSortedLists(l1, l2?.next)
      return l2
    }
  }
  //----------------------------------------------------------------------------------------------
  /*
   1 -> 2 -> 3 -> 4 -> 5 -> nil
   i = 3
   we have to keep track of prev.
   If i == 0, return head.next
   if i == n-1, prev.next = nil for last node.
   */
  func removeAtIndexInLinkedList(_ head: LinkedListNode<Int>?, _ index: Int) -> LinkedListNode<Int>? {
    if index < 0 || head == nil {
      return head
    }
    if index == 0 {
      return head?.next // If index is 0, return head.next
    }
    var i = 0
    var curr = head
    var prev: LinkedListNode<Int>? = nil
    while i < index && curr != nil {
      prev = curr
      curr = curr?.next
      i += 1
    }
    if curr == nil { // If index is out of bounds
      return head
    }
    prev?.next = curr?.next // Remove the node at index
    return head
  }
  
  //----------------------------------------------------------------------------------------------
  /*
   Reverse in K groups in a linked list.
   */
  
  func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
    var size = calculateSize(head)
    if size < k {
      return head
    }
    
    var kNextNode = calculateKNextNode(head, k)
    var next = reverseKGroup(kNextNode, k)
    
    var prev: ListNode? = nil
    var curr: ListNode? = head
    var pointer = 0
    
    while(pointer < k) {
      var nextNode = curr?.next
      curr?.next = prev
      prev = curr
      curr = nextNode
      pointer += 1
    }
    head?.next = next
    return prev
  }
  
  func calculateSize(_ head: ListNode?) -> Int {
    var node = head
    var size = 0
    while (node != nil) {
      size += 1
      node = node?.next
    }
    return size
  }
  
  func calculateKNextNode(_ head: ListNode?, _ k: Int) -> ListNode? {
    var node = head
    var pointer = 0
    while (pointer < k) {
      node = node?.next
      pointer += 1
    }
    return node
  }
  
  /*
   Merge K sorted linked lists.
   */
  func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
    var length = lists.count
    if length == 0 {
      return nil
    }
    return mergeLists(lists, 0, length-1)
  }
  
  func mergeLists(_ lists: [ListNode?], _ start: Int, _ end: Int) -> ListNode? {
    if end < start {
      return nil
    }
    if start == end {
      return lists[start]
    }
    
    var mid = start + (end - start)/2
    var firstHalf = mergeLists(lists, start, mid)
    var secondHalf = mergeLists(lists, mid + 1, end)
    
    var mergedList = merge2List(firstHalf, secondHalf)
    return mergedList
  }
  
  func merge2List(_ head1: ListNode?, _ head2: ListNode?) -> ListNode? {
    if head1 == nil {
      return head2
    }
    if head2 == nil {
      return head1
    }
    guard let val1 = head1?.val, let val2 = head2?.val else { return nil }
    if val1 <= val2 {
      var mergedHead = merge2List(head1?.next, head2)
      head1?.next = mergedHead
      return head1
    } else {
      var mergedHead = merge2List(head1, head2?.next)
      head2?.next = mergedHead
      return head2
    }
    return nil
  }
  
  /*
   Question Leetcode 2: Add Two Numbers
   */
  func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var curr1 = l1
    var curr2 = l2
    var carry = 0
    var newHead: ListNode? = nil
    var newPoiner = newHead
    
    while curr1 != nil && curr2 != nil {
      let val1 = curr1?.val ?? 0
      let val2 = curr2?.val ?? 0
      var add = val1 + val2 + carry
      var num = add % 10
      carry = add / 10
      
      let node = ListNode(num)
      if newHead == nil {
        newHead = node
        newPoiner = node
      } else {
        newPoiner?.next = node
        newPoiner = newPoiner?.next
      }
      
      curr1 = curr1?.next
      curr2 = curr2?.next
    }
    
    if curr1 == nil {
      addNumber(curr2, newPoiner, carry)
    } else if curr2 == nil {
      addNumber(curr1, newPoiner, carry)
    }
    
    // Handle carry if both lists were of equal length
    if curr1 == nil && curr2 == nil && carry > 0 {
      newPoiner?.next = ListNode(carry)
    }
    
    return newHead
  }
  
  func addNumber(_ curr: ListNode?, _ pointer: ListNode?, _ carry: Int) {
    var curr = curr
    var pointer = pointer
    var carr = carry
    
    while curr != nil {
      let val = curr!.val
      let sum = val + carr
      let num = sum % 10
      carr = sum / 10
      
      let node = ListNode(num)
      pointer?.next = node
      pointer = pointer?.next
      
      curr = curr?.next
    }
    
    if carr > 0 {
      pointer?.next = ListNode(carr)
    }
  }
  
  /*
   Question Leetcode 445: Add Two Numbers II
   */
  
  /*
   Question Leetcode 138: Copy List with Random Pointer
   */
  func copyRandomList(_ head: Node?) -> Node? {
    guard let head = head else {
      return nil
    }
    
    var hashTable: [Node: Node] = [:]
    var curr: Node? = head
    var prevCopy: Node? = nil
    
    // First pass: copy all nodes and store mapping in hashTable
    while let current = curr {
      let copy = Node(current.val)
      hashTable[current] = copy
      
      if let prev = prevCopy {
        prev.next = copy
      }
      
      prevCopy = copy
      curr = current.next
    }
    
    // Second pass: assign random pointers
    curr = head
    while let current = curr {
      if let copy = hashTable[current] {
        copy.random = current.random.flatMap { hashTable[$0] }
      }
      curr = current.next
    }
    
    return hashTable[head]
  }
  
  /*
   Question Leetcode 142: Linked List Cycle II
   */
  func detectCycle(_ head: ListNode?) -> ListNode? {
    var slow = head
    var fast = head
    var isCycle = false
    var meetingPoint: ListNode? = nil
    while fast?.next != nil && fast?.next?.next != nil {
      slow = slow?.next
      fast = fast?.next?.next
      
      if slow === fast {
        isCycle = true
        meetingPoint = slow
        break
      }
    }
    if isCycle {
      fast = head
      while slow !== fast {
        slow = slow?.next
        fast = fast?.next
      }
      return slow
    } else {
      return nil
    }
  }
  
  /*
   Question Leetcode 2816: Double a Number Represented as a Linked List
   */
  func doubleIt(_ head: LinkedListNode<Int>?) -> LinkedListNode<Int>? {
    guard let head = head else { return nil }
    
    // Step 1: Reverse the list
    let reversed = reverseLinkedListIteratively(head: head)
    
    // Step 2: Traverse and double
    var curr: LinkedListNode<Int>? = reversed
    var carry = 0
    var prev: LinkedListNode<Int>? = nil
    
    while let node = curr {
      let doubled = node.val * 2 + carry
      node.val = doubled % 10
      carry = doubled / 10
      
      prev = node
      curr = node.next
    }
    
    // Step 3: If carry remains, append new node
    if carry > 0 {
      prev?.next = ListNode(carry)
    }
    
    // Step 4: Reverse the list back and return
    return reverseLinkedListIteratively(head: reversed)
  }
  
  
  //Reservior Sampling Algorithm
  class Solution {
    private var head: LinkedListNode<Int>?
    
    init(_ head: LinkedListNode<Int>?) {
      self.head = head
    }
    
    func getRandom() -> Int {
      var curr = head
      var result = curr!.val
      var i = 1
      
      while let node = curr?.next {
        i += 1
        // Replace result with probability 1/i
        if Int.random(in: 0..<i) == 0 {
          result = node.val
        }
        curr = node
      }
      
      return result
    }
  }
  
  //How would you modify the algorithm to pick k random nodes (instead of just 1)?
  class Solution {
    private var head: LinkedListNode<Int>?
    private var reservoirSize: Int
    
    init(_ head: LinkedListNode<Int>?, _ k: Int) {
      self.head = head
      self.reservoirSize = k
    }
    
    func getRandomK() -> [Int] {
      var reservoir: [Int] = []
      var curr = head
      var i = 0
      
      while let node = curr {
        if i < reservoirSize {
          reservoir.append(node.val)
        } else {
          let j = Int.random(in: 0...i)
          if j < reservoirSize {
            reservoir[j] = node.val
          }
        }
        
        curr = node.next
        i += 1
      }
      
      return reservoir
    }
  }
  
}
