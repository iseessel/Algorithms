class Fixnum
end

class Array
  def hash
    self.each_with_index.inject(0) do |hash, (el, i)|
      (el.hash + i.hash) ^ hash
    end
  end
end

class String
  def hash
    self.chars.map(&:ord).hash
  end
end

class Hash
  def hash
    self.to_a.sort.hash
  end
end
