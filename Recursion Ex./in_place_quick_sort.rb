require 'byebug'

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    # 1) randomly choose anchor.
    pivot_idx = rand(array.length)
    pivot = array[pivot_idx]
    # 2) partition into right and left sides.
    left_side = []
    right_side = []
    array.each_with_index do |num, idx|
      next if idx == pivot_idx
      if num <= pivot
        left_side.push(num)
      else
        right_side.push(num)
      end
    end
    # 3) Concat the left side quicksorted with the right side quicksorted.
    self.sort1(left_side) + [pivot] + self.sort1(right_side)
  end

  # In-place.
  def self.sort2!(array, start = 0, end_idx = array.length - 1, &prc)
    # If there is one or less elements to sort return out
    return if end_idx - start < 1
    # Partition from start to end
    boundary = self.partition(array, start, end_idx, &prc)
    self.sort2!(array, start, boundary - 1, &prc)
    self.sort2!(array, boundary + 1, end_idx, &prc)
    array
  end

  def self.partition(array, start, end_idx, &prc)
    #By default sort from smallest to largest
    prc ||= proc { |x, y| x <=> y}

    #Select random pivot and switch it with the start.
    pivot_idx = rand(start..end_idx)
    array[start], array[pivot_idx] = array[pivot_idx], array[start]
    pivot_idx = start
    pivot = array[pivot_idx]
    boundary = start + 1

    (start + 1..end_idx).each do |idx|
      if prc.call(array[idx], pivot) == -1
        array[boundary], array[idx] = array[idx], array[boundary]
        boundary += 1
      end
    end
    #Switch with boundary - 1 because we want to switch with a SMALLER ELEMENT(Not a greater)
    array[pivot_idx], array[boundary - 1] = array[boundary - 1], array[pivot_idx]
    boundary - 1
  end
end
