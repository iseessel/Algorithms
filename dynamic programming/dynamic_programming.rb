=begin

Dynamic Programming

1) Combines memoization and recursion!
  a) Memoization => storing values of
    expensive functions that will be reused

  b) Recursion => Function that calls itself

  def fibonacci(n, cache = { 1: 1, 2: 1})
    # return 1 if n == 1 || n == 2
    # Check our cache instead of the original base case
    return cache[n] unless cache[n].nil?
    # Record our answer in our cache before returning it
    ans = fibonacci(n - 1) + fibonacci(n - 2)
    cache[n] = ans
    return ans
  end

Top-down vs Bottom up Dynamic Programming

1) Top Down: Fibs
  a) Starts at the top of the call tree and
    records answers as you get them

class Fibonacci

  def initialize
    @cache = {
      1: 1,
      2: 1
    }
  end


end

OR

def fibonacci(n, cache = {1 => 1, 2 => 1})
  return cache[n] unless cache[n].nil?
  ans = fibonacci(n - 1, cache) + fibonacci(n - 2, cache)
  cache[n] = ans
  return ans
end


2) How do we keep track of our @cache ?
    a) We can instantiate a class and keep track of it,
    b)  we can also pass it through the recursion.

2) Bottom up
  a) Start at the bototm of the call tree and record answer you
    know you'll need and return to the answer once you have it.

Top down dynamic programming works like this: Fibs(100) = Fibs(99) + fibs(98) = ...
But since we know every piece of information we neeed to produce
fibs(100) beforehand we can construct our tree BOTTOM UP


def fib_cache_builder(n)
  # Builds the cache, starting at 1 and ending at n
  cache = { 1 => 1, 2 => 1 }
  return cache if n < 3
  (3..n).each do |i|
    cache[i] = cache[i - 1] + cache[i - 2]
  end

  cache
end

def fibonacci(n)
  # Calls the helper function
  cache = fib_cache_builder(n)
  # Returns the nth entry
  cache[n]
end

What to do with the cache? Each run of the function
  must refer to the cache object; otherwise we can compute to things
  more than once.

Passed by reference vs. Passed by value:

  Reference: Reference to an object is passed into the function!
  Value: Called functions' parameter will be a copy of the caller's
    passed argument

NB: Ruby is pass by reference value i.e. copy of the reference value.


#NB: Using an outside cache is only helpful for TOP-DOWN dynamic Programming
problems. For bottom-up, we will be building the cache as we go along!

#NB: Realworld context: Just set up an object outside of the function and make it known that it
  is global in scope.

=end

require 'byebug'

class DynamicProgramming
  def initialize
    @blair_cache = {1 => 1, 2 => 1}
    @knapsack_matrix = []
  end
=begin
#[{weight: 1, value: 2},
  {weight: 2, value: 3},
  {weight: 4, value: 4},
  {weight: 3, value: 5}
]
=end

#{weight: 3, value: 4}, {weight: 2, value: 5}]

  def knapsack(items, max_weight)
    @knapsack_matrix = []
    #1) Basecase: For max-weight of 0, the max value you can get is 0
    (0...items.length).each do |index|
      @knapsack_matrix.push([0])
    end

    #2) Basecase: For only using 1 weight, if the weight of that object
      #is greater than the current max-weight, we cannot use it.
      #NB: The indeces of the columns of the matrix indicate the current max weight,
       #while the rows indeces represent the (number of elements chosen + 1)
    (0..max_weight).each do |max_weight|
      if items[0][:weight] > max_weight
        @knapsack_matrix[0][max_weight] = 0
      else
        @knapsack_matrix[0][max_weight] = items[0][:value]
      end
    end

    #Recursive Case: Go through each row.
    # If we cannot use the item (i.e. its weight is too big) we get the max weight from above
    # If we can use the item take max of using the item and not using the item!
    (1...items.length).each do |i|
      (1..max_weight).each do |j|
        if items[i][:weight] > j
          @knapsack_matrix[i][j] = @knapsack_matrix[i - 1][j]
        else
          current_item = items[i]
          @knapsack_matrix[i][j] = [@knapsack_matrix[i - 1][j],
            current_item[:value] +  @knapsack_matrix[i - 1][j - current_item[:weight]]
          ].max
        end
      end
    end

  end

  def trace_matrix(items, cords = [@knapsack_matrix.length - 1, @knapsack_matrix[0].length - 1] )
    #If we've reached 0 max weight then there are no more possible items

    #If we've reached no more items
    if cords[0] == 0
      #If the first item is NOT in it, its weight will be 0
      if @knapsack_matrix[cords[0]][cords[1]] == 0
        return
      else
        return [items[cords[0]]]
      end
    end

    #If we've reached the first row then we know we've used that item.

    #If we got the value from the top, we are not using that thing
    if @knapsack_matrix[cords[0]][cords[1]] == @knapsack_matrix[cords[0] - 1][cords[1]]
        return trace_matrix(items, [cords[0] - 1, cords[1]] )
    #If we got the value from up and left, we ARE using that thing

    else
      [items[cords[0]]] + trace_matrix(items,
        [cords[0] - 1, cords[1] - (items[cords[0]][:weight])]
      )
    end
  end

  def generate_blair_cache(n)

    blair_cache = {
      1 => 1,
      2 => 2
    }

    (3..n).each do |int|
      blair_cache[n] = blair_cache[n - 1] + blair_cache[n - 2] + odd(n - 1)
    end

    blair_cache
  end

  def blair_nums(n)
    #Top-Down Implementation
    # return @blair_cache[n] if @blair_cache[n]
    # @blair_cache[n] = blair_nums(n - 1) + blair_nums(n - 2) + odd(n - 1)

    #Bottom-Up Implementation
    cache = generate_blair_cache(n)
    cache[n]
  end

  def odd(n)
    1 + (2 * (n - 1))
  end

#1) Frog can only jump 1, 2, or 3 steps at a time
#2) Generate how many ways a frog can get to the
# top of the stairs.

#Basecase: If frog is at top of the stairs return []
# If @cache[current_position] return @cache_current_position

# Go through each of the move differentials
  # Add current move + all the possible moves it takes a frog
  # to get to from the next step.

# Dynamic programming: Cache these things appropriately

  def frog_cache_builder(n, moves)
    frog_moves = {
      0 => [[]]
    }

    (1..n).each do |i|
      all_moves = []
      moves.each do |move|
        next unless frog_moves[i - move]
        next_moves = frog_moves[i - move].dup.map do |arr|
          arr.dup.unshift(move)
        end
        all_moves += next_moves
      end
      frog_moves[i] = all_moves
    end

    frog_moves
  end

  def frog_hops_bottom_up(n)
    cache = frog_cache_builder(n)
    cache[n]
  end

end

#Takes in array of weights, values, and weight capacity
#Returns the maximum value possible given weight constreight


# Given set of item with a weight and value and a weight capacity
# return the maximum value possible given the weight constraint

=begin
#Given set of items with a weight and a value:
  # 1) Determine number of each item to include in a collection
    # so that the total weight is less than or equal to a given limit
    # and the total value is large as possible

weight = [1, 2, 3]
values = [10, 4, 8]
capacity = 3


Basecase: If capacity is 0 return []

Recursive Case:

2d @knapsack_matrix

=end
