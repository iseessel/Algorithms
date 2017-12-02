require_relative 'heap'

def k_largest_elements(array, k)
  prc = proc{ |x,y| y <=> x }
  heaped_array = array
  k_largest = []
  idx = 0
  until idx >= array.length
     BinaryMinHeap.heapify_up(heaped_array, idx, idx + 1, &prc)
     idx += 1
  end

  k.times do |_|
    heaped_array[0], heaped_array[-1] = heaped_array[-1], heaped_array[0]
    k_largest.unshift(heaped_array.pop)
    BinaryMinHeap.heapify_down(heaped_array, 0, heaped_array.length, &prc)
  end

  k_largest
end
