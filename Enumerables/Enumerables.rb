require 'byebug'

class Array

  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    self
  end

  def my_select(&prc)
    select_arr = []
    self.my_each do |el|
      select_arr << el if prc.call(el)
    end
    select_arr
  end

  def my_reject(&prc)
    reject_arr = []
    self.my_each do |el|
      reject_arr << el unless prc.call(el)
    end
    reject_arr
  end

  def my_any?(&prc)
    self.my_each do |el|
      return true if prc.call(el)
    end
    false
  end

  def my_all?(&prc)
    self.my_each do |el|
      return false unless prc.call(el)
    end
    true
  end

  def my_flatten
    flat_array = []
    self.each do |el|
      if !el.is_a? Array
        flat_array << el
      else
        flat_array += el.my_flatten
      end
    end
    flat_array
  end



a = [1,2,[3]]
p a.my_flatten


  def my_zip(*args)
    zip_arr = []
    self.each_with_index do |el, idx|
      nest_arr = [el]
      args.each do |arg|
        nest_arr << arg[idx]
      end
      zip_arr << nest_arr
    end
    zip_arr
  end

  def my_rotate(arg = 1)
    true_rotate = arg % self.length
    if true_rotate > 0
      arr = self.dup
      append = arr.shift(true_rotate)
      return arr + append
    else
      arr = self.dup
      append = arr.pop(true_rotate.abs)
      return append + arr
    end
  end


    def my_join(seperator = "")
      join_str = ""
      self.each do |el|
        join_str += el + seperator
      end
      join_str[0...-1]
    end

    def my_reverse
      reverse_arr = []
      i = self.length - 1
      while i >= 0
        reverse_arr << self[i]
        i += -1
      end
      reverse_arr
    end



end

# ### Factors
#
# Write a method `factors(num)` that returns an array containing all the
# factors of a given number.

def factors(num)
  factors_arr = (1..num/2).select do |int|
    num % int == 0
  end
  factors_arr << num
end

# ### Bubble Sort
#
# http://en.wikipedia.org/wiki/bubble_sort
#
# Implement Bubble sort in a method, `Array#bubble_sort!`. Your method should
# modify the array so that it is in sorted order.
#
# > Bubble sort, sometimes incorrectly referred to as sinking sort, is a
# > simple sorting algorithm that works by repeatedly stepping through
# > the list to be sorted, comparing each pair of adjacent items and
# > swapping them if they are in the wrong order. The pass through the
# > list is repeated until no swaps are needed, which indicates that the
# > list is sorted. The algorithm gets its name from the way smaller
# > elements "bubble" to the top of the list. Because it only uses
# > comparisons to operate on elements, it is a comparison
# > sort. Although the algorithm is simple, most other algorithms are
# > more efficient for sorting large lists.
#
# Hint: Ruby has parallel assignment for easily swapping values:
# http://rubyquicktips.com/post/384502538/easily-swap-two-variables-values
#
# After writing `bubble_sort!`, write a `bubble_sort` that does the same
# but doesn't modify the original. Do this in two lines using `dup`.
#
# Finally, modify your `Array#bubble_sort!` method so that, instead of
# using `>` and `<` to compare elements, it takes a block to perform the
# comparison:
#
# ```ruby
# [1, 3, 5].bubble_sort! { |num1, num2| num1 <=> num2 } #sort ascending
# [1, 3, 5].bubble_sort! { |num1, num2| num2 <=> num1 } #sort descending
# ```
#
# #### `#<=>` (the **spaceship** method) compares objects. `x.<=>(y)` returns
# `-1` if `x` is less than `y`. If `x` and `y` are equal, it returns `0`. If
# greater, `1`. For future reference, you can define `<=>` on your own classes.
#
# http://stackoverflow.com/questions/827649/what-is-the-ruby-spaceship-operator

class Array
  def bubble_sort!(&prc)
    prc ||= Proc.new { |num1, num2| num1 <=> num2 }
    all_finish = false
    until all_finish
      all_finish = true
      self.each_index do |idx|
        if prc.call(self[idx], self[idx+1]) == 1
          self[idx], self[idx+1] = self[idx+1], self[idx]
          all_finish = false
        end
        break if idx == self.length - 2
      end
    end
    self
  end

  def bubble_sort(&prc)
    self.dup.bubble_sort!(&prc)
  end

end

# ### Substrings and Subwords
#
# Write a method, `substrings`, that will take a `String` and return an
# array containing each of its substrings. Don't repeat substrings.
# Example output: `substrings("cat") => ["c", "ca", "cat", "a", "at",
# "t"]`.
#
# Your `substrings` method returns many strings that are not true English
# words. Let's write a new method, `subwords`, which will call
# `substrings`, filtering it to return only valid words. To do this,
# `subwords` will accept both a string and a dictionary (an array of
# words).

def substrings(string)
  sub_arr = []
  (0...string.length).each do |start_idx|
    (start_idx...string.length).each do |end_idx|
      sub_arr << string[start_idx..end_idx]
    end
  end
  sub_arr.uniq
end

def subwords(word, dictionary)
  sub_string = substrings(word)
  sub_string.select { |sub| dictionary.include?(sub)}
end

# ### Doubler
# Write a `doubler` method that takes an array of integers and returns an
# array with the original elements multiplied by two.

def doubler(array)
   array.map { |el| el * 2}
end


# ### My Enumerable Methods
# * Implement new `Array` methods `my_map` and `my_select`. Do
#   it by monkey-patching the `Array` class. Don't use any of the
#   original versions when writing these. Use your `my_each` method to
#   define the others. Remember that `each`/`map`/`select` do not modify
#   the original array.
# * Implement a `my_inject` method. Your version shouldn't take an
#   optional starting argument; just use the first element. Ruby's
#   `inject` is fancy (you can write `[1, 2, 3].inject(:+)` to shorten
#   up `[1, 2, 3].inject { |sum, num| sum + num }`), but do the block
#   (and not the symbol) version. Again, use your `my_each` to define
#   `my_inject`. Again, do not modify the original array.

class Array
  def my_map(&prc)
    map_arr = []
    self.my_each do |el|
      map_arr << prc.call(el)
    end
    map_arr
  end

  def my_inject(&blk)
    acc = self[0]
    self[1..-1].my_each do |el|
      acc = blk.call(acc, el)
    end
    acc
  end
end

# ### Concatenate
# Create a method that takes in an `Array` of `String`s and uses `inject`
# to return the concatenation of the strings.
#
# ```ruby
# concatenate(["Yay ", "for ", "strings!"])
# # => "Yay for strings!"
# ```

def concatenate(strings)
  strings.inject{ |acc, string| acc + string }
end
