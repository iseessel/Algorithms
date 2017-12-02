require_relative 'p02_hashing'
require_relative 'p01_int_set'

class HashSet < ResizingIntSet
  attr_reader :count

  private

  def [](val)
    @store[val.hash % num_buckets]
  end

end
