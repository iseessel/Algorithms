# This class just dumbs down a regular Array to be statically sized.
class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  protected
  attr_accessor :store

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end
