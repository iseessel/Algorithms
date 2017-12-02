require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    prc ||= Proc.new{|left, right| left <=> right}
    @prc = prc
    @store = []
  end
  def count
    @store.count
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    top_el = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, @store.length, &@prc)
    top_el
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, @store.length - 1, @store.length, &@prc)
  end

  public

  def self.child_indices(len, parent_index)
    children = []
    double_parent_index = 2 * parent_index
    children.push(double_parent_index + 1) unless
      double_parent_index + 1 > len - 1
    children.push(double_parent_index + 2) unless
      double_parent_index + 2 > len - 1
    children
  end

  def self.parent_index(child_index)
    return nil if child_index <= 0
    (child_index - 1)/2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= proc{|left, right| left <=> right}
    parent_el = array[parent_idx]
    children = self.child_indices(len, parent_idx)
    # this checks both if the children are empty or the correct heap comparison
      # between the child element and the parent element.
    return array if children.all? do |child_idx|
      prc.call(parent_el, array[child_idx]) != 1
    end
    if children[1] && prc.call(array[children[0]], array[children[1]]) == 1
      child_to_switch = children[1]
      new_parent_idx = children[1]
    else
      child_to_switch = children[0]
      new_parent_idx = children[0]
    end
    array[child_to_switch], array[parent_idx] = array[parent_idx],
      array[child_to_switch]
      return self.heapify_down(array, new_parent_idx, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return nil if len > array.length
    prc ||= proc{ |left, right| left <=> right }
    parent_idx = self.parent_index(child_idx)
    if parent_idx &&
      prc.call(array[child_idx], array[parent_idx]) != 1
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      child_idx = parent_idx
    else
      return array
    end

    BinaryMinHeap.heapify_up(array, child_idx, len, &prc)
  end
end
