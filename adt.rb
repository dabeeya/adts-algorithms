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

# deck = SimpleStack.new
# deck.push(1)
# deck.push(2)
# deck.push(3)
# deck.peek

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

# line = SimpleQueue.new
# line.enqueue(1)
# line.enqueue(2)
# line.enqueue(3)
# puts line.size
# line.dequeue
# puts line.size
# line.show





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

#random node, was creating a tree
# class Node
#   attr_accessor :value, :leftchild, :rightchild

#   def initialize (value)
#     @value = value
#   end

# end

# class Tree
#   attr_accessor :root

#   def initialize()
#   end

#   def add
#   end

# end

#Algorithms
#bubble sort
def bubblesortmine(array)
  n = array.length
  swapped = false
  while !swapped do
    swapped = true
    (n-1).times do |i|
      if array[i] > array[i+1]
        array[i], array[i+1] = array[i+1],array[i]
        swapped = false
      end
    end
  end
  print array
end
bubblesortmine([100,1,8,7,6,-1,4])

#merge sort

def mergesort(array)
  def merge(left_sorted, right_sorted)
    res = []
    l = 0
    r = 0

    loop do
      break if r >= right_sorted.length and l >= left_sorted.length

      if r >= right_sorted.length or (l < left_sorted.length and left_sorted[l] < right_sorted[r])
        res << left_sorted[l]
        l += 1
      else
        res << right_sorted[r]
        r += 1
      end
    end

    return res
  end

  def mergesort_iter(array_sliced)
    return array_sliced if array_sliced.length <= 1

    mid = array_sliced.length/2 - 1
    left_sorted = mergesort_iter(array_sliced[0..mid])
    right_sorted = mergesort_iter(array_sliced[mid+1..-1])
    return merge(left_sorted, right_sorted)
  end

  mergesort_iter(array)
end

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

class Array
  def binary_search_iterative(val)
    low, high = 0, length - 1
    while low <= high
      mid = (low + high) / 2
      case
        when self[mid] > val then high = mid - 1
        when self[mid] < val then low = mid + 1
        else return mid
      end
    end
    nil
  end
end

ary = [0,1,4,5,6,7,8,9,12,26,45,67,78,90,98,123,211,234,456,769,865,2345,3215,14345,24324]

[0,42,45,24324,99999].each do |val|
  i = ary.binary_search_iterative(val)
  if i
    puts "found #{val} at index #{i}: #{ary[i]}"
  else
    puts "#{val} not found in array"
  end
end
