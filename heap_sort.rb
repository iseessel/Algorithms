require_relative "heap"

class Array
  def heap_sort!
    prc = proc{ |x,y| y <=> x }

    idx = 0
    until idx >= self.length
       BinaryMinHeap.heapify_up(self, idx, idx + 1, &prc)
       idx += 1
    end

    idx -= 1
    until idx < 0
      self[0], self[idx] = self[idx], self[0]
      BinaryMinHeap.heapify_down(self, 0, idx, &prc)
      idx -= 1
    end

    self
  end
end
