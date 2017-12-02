require 'byebug'

class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = @next
    @next.prev = @prev
    @next = nil
    @val = nil
  end
end

class LinkedList
  include Enumerable
  attr_reader :head
  def initialize
    @head = Node.new()
    @tail = Node.new()
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    node = find_node(key)
    node ?  node.val : nil
  end

  def include?(key)
    !!find_node(key)
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.prev = @tail.prev
    new_node.next = @tail
    @tail.prev.next = new_node
    @tail.prev = new_node
    new_node
  end

  def update(key, val)
    node = find_node(key)
    node ? node.val = val : nil
  end

  def remove(key)
    node = find_node(key)
    node ? node.remove : nil
  end

  def each(&prc)
    current_node = @head.next
    until current_node == @tail
      prc.call(current_node)
      current_node = current_node.next
    end

    @head
  end

  private

  def find_node(key)
    current_node = @head
    until current_node == @tail
      if current_node.key == key
        return current_node
      end
      current_node = current_node.next
    end

    nil
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
  
end
