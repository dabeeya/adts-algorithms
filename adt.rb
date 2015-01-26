#STACK for ruby, easy way bc we use push and pop methods
#arrays in ruby are dynamic, we dont set a length like in java

class SimpleStack
  def initialize
    @store = []
  end

  def pop
    @store.pop
  end

  def push(element)
    @store.push(element)
    self
  end

  def size
    @store.length
  end

  def peek
    #or can use .last method
    num = @store.length - 1
    puts @store[num]
  end
end

#a more complex version of stack
class Stack
  def initialize(size)
    @size = size
    @store = Array.new(@size)
    @top = -1
  end

#i dont really like this pop method
  def pop
    if empty?
      puts "Stack is empty"
    else
      popped = @store[@top]
      @store[@top] = nil
      @top = @top.pred
      popped
    end
  end

  def push(element)
    if full? or element.nil?
      nil
    else
      @top = @top.succ
      @store[@top] = element
      self
    end
  end

  def size
    @size
  end

  def look
    @store[@top]
  end

  private

  def full?

    @top == (@size - 1)
  end

  def empty?
    @top == -1
  end
end

#QUEUE
class SimpleQueue
  def initialize
    @store = []
  end

  #should remove first element
  def dequeue
    @store.shift
  end

  def enqueue(element)
    @store.push(element)
  end

  def size
    @store.size
  end

  def show
    @store.each do |x|
      print x
    end
  end
end

#more complex version
class Queue
  def initialize(size)
    @size = size
    @store = Array.new(@size)
    @head, @tail = -1, 0
  end

  def dequeue
    if empty?
      nil
    else
      @tail = @tail.succ

      dequeued = @store[@head]
      @store.unshift(nil)
      @store.pop
      dequeued
    end
  end

  def enqueue(element)
    if full? or element.nil?
      nil
    else
      @tail = @tail.pred
      @store[@tail] = element
      self
    end
  end

  def size
    @size
  end

  private

  def empty?
    @head == -1 and @tail == 0
  end

  def full?
    @tail.abs == (@size)
  end
end

#linked list from http://www.thelearningpoint.net/computer-science/basic-data-structures-in-ruby---linked-list---a-simple-singly-linked-list
class Node
  attr_accessor :value, :next_node

  def initialize(val,next_in_line)
    @value = val
    @next_node = next_in_line
    #puts "Initialized a Node with value:  " + value.to_s
  end
end


class LinkedList
  def initialize(val)
      # Initialize a new node at the head
      @head = Node.new(val,nil)
  end

  def add(value)
    # Traverse to the end of the list
    # And insert a new node over there with the specified value
    current = @head
      while current.next_node != nil
        current = current.next_node
      end
      current.next_node = Node.new(value,nil)
      self
  end

  def delete(val)
    current = @head
    if current.value == val
      # If the head is the element to be delete, the head needs to be updated
      @head = @head.next_node
    else
      # ... x -> y -> z
      # Suppose y is the value to be deleted, you need to reshape the above list to :
      #   ... x->z
      # ( and z is basically y.next_node )
      current = @head
      while (current != nil) && (current.next_node != nil) && ((current.next_node).value != val)
        current = current.next_node
      end

      if(current != nil) && (current.next_node != nil)
        current.next_node = (current.next_node).next_node
      end
    end
  end

  def display
    # Traverse through the list till you hit the "nil" at the end
    current = @head
    full_list = []
    while current.next_node != nil
      full_list += [current.value.to_s]
      current = current.next_node
    end
      full_list += [current.value.to_s]
      puts full_list.join("->")
  end
end

ll = LinkedList.new(1)
ll.add(3)
ll.add(4)
ll.display

#btree
class Node
  attr_accessor :value, :leftchild, :rightchild
  def initialize (value, leftchildv, rightchildv)
    @value = value
    @leftchild = leftchildv
    @rightchild = rightchildv
  end
end

class BTree
  def initialize(value)
    @root = Node.new(value, nil, nil)
  end

  def add()
  end

  def delete
  end

end

#Algorithms
#bubble sort
def bubblesort_mine(array)
  n = array.length
  swapped = true
  while swapped
    swapped = false
    (n-1).times do |i|
      if array[i] > array[i+1]
        array[i], array[i+1] = array[i+1],array[i]
        swapped = true
      end
    end
  end
  print array
end
bubblesort_mine([100,1,8,7,6,-1,4])

#merge sort



#binary search RECURSIVE
class Array
  def binary_search(val, low=0, high=(length - 1))
    return nil if high < low
    mid = (low + high) / 2
    case
      when self[mid] > val then binary_search(val, low, mid-1)
      when self[mid] < val then binary_search(val, mid+1, high)
      else mid
    end
  end
end

ary = [0,1,4,5,6,7,8,9,12,26,45,67,78,90,98,123,211,234,456,769,865,2345,3215,14345,24324]

[0,42,45,24324,99999].each do |val|
  i = ary.binary_search(val)
  if i
    puts "found #{val} at index #{i}: #{ary[i]}"
  else
    puts "#{val} not found in array"
  end
end

#binary search iterative

# class Array
#   def binary_search_iterative(val)
#     low, high = 0, length - 1
#     while low <= high
#       mid = (low + high) / 2
#       case
#         when self[mid] > val then high = mid - 1
#         when self[mid] < val then low = mid + 1
#         else return mid
#       end
#     end
#     nil
#   end
# end

# ary = [0,1,4,5,6,7,8,9,12,26,45,67,78,90,98,123,211,234,456,769,865,2345,3215,14345,24324]

# [0,42,45,24324,99999].each do |val|
#   i = ary.binary_search_iterative(val)
#   if i
#     puts "found #{val} at index #{i}: #{ary[i]}"
#   else
#     puts "#{val} not found in array"
#   end
# end

# merge sort
def merge_sort(array)
  return array if array.size <= 1
  left = merge_sort(array[0, array.size / 2])
  right = merge_sort(array[array.size / 2, array.size])

  merge(left, right)
end


def merge(left, right)
  result = []

  while left.size > 0 && right.size > 0
    result << if left[0] <= right[0]
      left.shift
    else
      right.shift
    end
  end

  result.concat(left).concat(right)
end

p merge_sort([1,5,6,3,2,0])

def selection_sort(arr)
  for index in 0..(arr.length-1)
    temp = arr[index]
    min = temp
    indexToSwap = index
    for selectedIndex in (index+1)..(arr.length-1)
      if arr[selectedIndex] < min
        min = arr[selectedIndex]
        indexToSwap = selectedIndex
      end
    end
    arr[indexToSwap] = temp
    arr[index] = min
  end
end

def selectionsort(list)
  list.size.times do |start|
    min = start
    start.upto(list.size-1) do |i|
      min = i if list[i] < list[min]
    end
    list[start], list[min] = list[min], list[start]
  end
  list
end

def insertion_sort(arr)
  for size in 2..arr.length
    # Remember, this is a zero-start array
    element = arr[size-1]

      # Bring this element down to its appropriate position
      # elements[0] ... elemets[size-2] are already in a sorted order
      index = size - 2
      while(index >= 0) && (element < arr[index])
          arr[index + 1] = arr[index]
          index-=1
          # print arr
      end
    arr[index+1] = element
  end
  print arr
end

insertion_sort([5,3,1,0])
# uses each_with_index method
def insertion_sort2(array)
  array.each_with_index do |ele,i|
    j = i - 1
    while j >= 0
      break if array[j] <= ele
      array[j + 1] = array[j]
      j -= 1
    end
    array[j + 1] = ele
  end
end

p insertion_sort2([4,3,2,1])



# binary search log n, finds the position, but array must be sorted to use binary search
def binary_search(array, key, low=0, high=array.size-1)
  return -1 if low > high
  mid = (low + high) / 2
  return mid if array[mid]==key
  if array[mid] > key
    high = mid - 1
  else
    low = mid + 1
  end
  binary_search(array, key, low, high)
end

ary = [1,2,3,4,5,6,7,8]
puts binary_search(ary, 8)

def largest(arr)
  s = arr.first
  arr.each do |x|
    if x > s
      s = x
    end
  end
  puts s
end

largest([1,4,6,7,9])



# binary search tree

class TreeNode
    attr_accessor :value, :left, :right

    # The Tree node contains a value, and a pointer to two children - left and right
    # Values lesser than this node will be inserted on its left
    # Values greater than it will be inserted on its right
    def initialize val,left,right
        @value = val
        @left = left
        @right = right
    end
end

class BinarySearchTree

    # Initialize the Root Node
    def initialize val
        puts "Initializing with: " + val.to_s
        @root = TreeNode.new(val,nil,nil)
    end

    # Pre-Order Traversal
    def preOrderTraversal(node= @root)
        return if (node == nil)
        puts node.value.to_s
        preOrderTraversal(node.left)
        preOrderTraversal(node.right)
    end

    # Post-Order Traversal
    def postOrderTraversal(node = @root)
        return if (node == nil)
        postOrderTraversal(node.left)
        postOrderTraversal(node.right)
        puts node.value.to_s
    end

    # In-Order Traversal : Displays the final output in sorted order
    # Display smaller children first (by going left)
    # Then display the value in the current node
    # Then display the larger children on the right
    def inOrderTraversal(node = @root)
        return if (node == nil)
        inOrderTraversal(node.left)
        puts node.value.to_s
        inOrderTraversal(node.right)
    end


    # Inserting a value
    # When value > current node, go towards the right
    # when value < current node, go towards the left
    # when you hit a nil node, it means, the new node should be created there
    # Duplicate values are not inserted in the tree
    def insert(value)
        puts "Inserting :" + value.to_s
        current_node = @root
        while nil != current_node
            if (value < current_node.value) && (current_node.left == nil)
                current_node.left = TreeNode.new(value,nil,nil)
            elsif  (value > current_node.value) && (current_node.right == nil)
                current_node.right = TreeNode.new(value,nil,nil)
            elsif (value < current_node.value)
                current_node = current_node.left
            elsif (value > current_node.value)
                current_node = current_node.right
            else
                return
            end
        end
    end
end

a = [ 1, 2, 3, 3, 4, 3, 3]
h = {}
a.each { | v | h.store(v, h[v]+1) }
p h
p h.key(4)

