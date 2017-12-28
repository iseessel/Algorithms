require_relative 'heap2'

class PriorityMap
  def initialize(&prc)
    @prc = prc
    @map = {}
    @queue = BinaryMinHeap.new { |x, y| @map[x][:cost] <=> @map[y][:cost] }
  end

  def [](key)
    @map[key]
  end

  def []=(key, value)
    if has_key?(key)
      update(key, value)
    else
      insert(key, value)
    end
  end

  def count
    @queue.count
  end

  def empty?
    @queue.empty?
  end

  def extract
    smallest_key = @queue.extract
    extracted = [smallest_key, @map[smallest_key]]
    @map.delete(smallest_key)
    extracted
  end

  def has_key?(key)
    !!@map[key]
  end

  protected
  attr_accessor :map, :queue

  def insert(key, value)
    @map[key] = value
    @queue.push(key)
  end

  def update(key, value)
    @map[key] = value
    @queue.reduce!(key)
  end
end
