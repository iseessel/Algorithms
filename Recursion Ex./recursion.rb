require 'byebug'

def range(start, finish)
  return [start] if start == finish
  return [] if finish < start

  [start] + range(start+1, finish)
end

p range(1,5)

def exp1(b,n)
  return 1 if n == 0
  b * exp1(b, n-1)
end

def exp2(b,n)
  return 1 if n == 0
  return b if n == 1
  if n.even?
    square = exp2(b, n/2)
    square * square
  elsif n.odd?
    square = exp2(b, (n-1) / 2)
    b * square * square
  end

end

class Array
  def deep_dup
    return self.dup if self.none? {|el| el.class == Array} # we do not need the basecase, because if we go through each element
    self.map do |el| # and there are no elements it will just return an empty array.
      if !el.is_a? Array
        el
      else
        el.deep_dup
      end
    end
  end
end

def fib(n)
  return [0,1].take(n) if n <= 2
  previous_fib = fib(n-1)
  previous_fib << previous_fib[-1] + previous_fib[-2]
end

def subsets(arr)
  return [[]] if arr.empty?
  subset_arr = [arr.dup]
  arr.each_index do |idx|
    arr_no_index = arr[0...idx] + arr[idx + 1..-1]
    next_subset = subsets(arr_no_index)
    subset_arr = subset_arr | next_subset
  end
  subset_arr
end



def permutations(arr)
  return arr if arr.length <= 1
  perm_arr = []
  arr.each_with_index do |el, idx|
    slice_perm = permutations(arr[0...idx] + arr[idx+1..-1])
    slice_perm.each do |sub_el|
      perm_arr << [el] + [sub_el].flatten #disatisfied with flattening this would like the recursion to take care of it on its own.
    end
  end

  perm_arr
end


def bsearch(arr, target)
  middle_idx = arr.length/2
  middle_el = arr[middle_idx]

  return middle_idx if middle_el == target
  return nil if arr.empty?

  if target < middle_el
    bsearch(arr[0...middle_idx], target)
  else
    search_tree = bsearch(arr[middle_idx + 1..-1], target) # change this to drop
    return nil unless search_tree
    middle_idx + 1 + search_tree
  end
end

def mergesort(arr)
  return arr if arr.length == 1 # create middle variable
  left_arr = mergesort(arr[0...arr.length/2])
  right_arr = mergesort(arr[arr.length/2..-1])
  merge(left_arr, right_arr) #separation of concerns; merging each mergesort
end

def merge(arr1, arr2) #can we make this recursive? if arr1.length == 1 and arr2.length =
  new_arr = []
  until arr1.empty? && arr2.empty?
    if arr1.empty?
      new_arr << arr2.shift
    elsif arr2.empty?
      new_arr << arr1.shift
    elsif arr1.first < arr2.first
      new_arr << arr1.shift
    elsif arr2.first <= arr1.first
      new_arr << arr2.shift
    end
  end

  new_arr
end

arr = (1..1000).to_a.shuffle
p

def greedy_make_change(amount, coins = [25, 10, 5, 1])
  return [amount] if coins.include?(amount)
  greatest_coin = coins.select{ |coin| coin < amount }.first
  [greatest_coin] + greedy_make_change(amount - greatest_coin, coins)
end

def make_better_change(amount, coins = [25, 10, 5, 1]) #how not to check for duplicates i.e. 25 10 5 vs. 5 10 25; very slow algorithm.
  return [amount] if coins.include?(amount)
  best_solution = nil
  current_coins = coins.select{ |curr_coin| curr_coin < amount }
  current_coins.each_with_index do |coin, idx|
    current_solution = [coin] + make_better_change(amount - coin, current_coins.drop(idx))
    best_solution = current_solution if !best_solution || current_solution.length < best_solution.length
  end
  best_solution
  # best_solution = a if a.length < best_solution
end


p make_better_change(84)
