require_relative "static_array"

class RingBuffer
  attr_reader :length

  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[mod_index(index)]
  end

  # O(1)
  def []=(index, value)
    until index <= @capacity
      resize!
    end
    @store[mod_index(index)] = value
  end

  # O(1)
  def pop
    raise("index out of bounds") if @length == 0
    old_el = @store[end_idx]
    @store[end_idx] = nil
    @length -= 1
    old_el
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length >= @capacity
    @length += 1
    @store[end_idx] = val
  end

  def shift
    raise("index out of bounds") if @length == 0
    old_el = @store[@start_idx]
    @store[@start_idx] = nil
    @length -= 1
    @start_idx = (@start_idx + 1) % @capacity
    old_el
  end

  def unshift(val)
    resize! if @length >= @capacity
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = val
    @length += 1
  end

  # protected
  attr_accessor :capacity, :store
  attr_writer :length

   def mod_index(idx)
    (@start_idx + idx) % @capacity
  end

  def end_idx
    mod_index(@length - 1)
  end

  def check_index(index)
    raise("index out of bounds") unless index < @length
  end

  def resize!
    old_store = @store
    @capacity *= 2
    @store = StaticArray.new(@capacity)
    i = 0
    (@start_idx...@length).each do |idx|
      @store[i] = old_store[idx]
      i += 1
    end
    (0...@start_idx).each do |idx|
      @store[i] = old_store[idx]
      i += 1
    end
    @start_idx = 0
  end

end
