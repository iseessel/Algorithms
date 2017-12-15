require_relative "static_array"
require 'byebug'

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    idx = mod_index(index)
    check_index(idx)
    @store[idx]
  end

  # O(1)
  def []=(index, value)
    idx = mod_index(index)
    until idx <= @capacity
      resize!
    end
    check_index(idx)
    @store[idx] = value
  end

  # O(1)
  def pop
    raise("index out of bounds") if @length == 0
    @store[@length - 1] = nil
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length >= @capacity
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise("index out of bounds") if @length == 0
    old_store = @store
    @store = StaticArray.new(@capacity)
    (1...@length).each do |i|
      @store[i - 1] = old_store[i]
    end
    @length -= 1
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length >= @capacity
    old_store = @store
    @store = StaticArray.new(@capacity)
    (0...@length).each do |i|
      @store[i + 1] = old_store[i]
    end
    @store[0] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def mod_index(idx)
    idx % @capacity
  end

  def check_index(index)
    raise("index out of bounds") unless index < @length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    old_store = @store
    @capacity *= 2
    @store = StaticArray.new(@capacity)
    (0...@length).each do |i|
      @store[i] = old_store[i]
    end
  end
end
