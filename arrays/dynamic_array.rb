require_relative "static_array"
require 'byebug'

class DynamicArray < StaticArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
  end

  # O(1)
  def [](index)
    validate(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    until index < @capacity
      resize!
    end
    @store[index] = value
  end

  # O(1)
  def pop
    old_val = self[@length - 1]
    self[@length - 1] = nil
    @length -= 1
    old_val
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    @length += 1
    resize!
    self[@length - 1] = val
    val
  end

  # O(n): has to shift over all the elements.
  def shift

  end

  # O(n): has to shift over all the elements.
  def unshift(val)
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    if @length > @capacity
      old_store = @store
      @capacity = @capacity * 2
      @store = StaticArray.new(@capacity)
      i = 0
      while i < @length
        @store[i] = old_store[i]
        i += 1
      end
    end

    @store
  end

  def validate(i)
    raise "index out of bounds" unless i.between?(0, @length - 1)
  end

end
