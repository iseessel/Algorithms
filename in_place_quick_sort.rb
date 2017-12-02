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
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return if length <= 1
    boundary = self.partition(array, start, length, &prc)
    self.sort2!(array, start,  boundary - start, &prc)
    self.sort2!(array, boundary + 1, (length - boundary) - 1, &prc)
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= proc{ |x, y| x <=> y}
    pivot_idx = start
    boundary = pivot_idx
    pivot = array[pivot_idx]


    (start...start + length).each do |idx|
      next if idx == pivot_idx
      if prc.call(array[idx], pivot) == -1
        boundary += 1
        array[idx], array[boundary] = array[boundary], array[idx]
      end
    end

    array[pivot_idx], array[boundary] = array[boundary], array[pivot_idx]
    boundary
  end
end
