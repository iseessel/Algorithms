require 'byebug'

class Subset

  def initialize(set)
    @set = set
    @matrix = []
  end

  def can_sum?(target)
    setup_matrix(target)

    #Every set can sum up to 0, by using the empty set
    (0...@matrix.length).each do |row|
      @matrix[row][0] = true
    end

    #A subset of set with one element can only sum to a number iff that
      #number is 0(taken care above) or that element equals the target
    (1...@matrix[0].length).each do |col|
      if @set[0] == col
        @matrix[0][col] = true
      else
        @matrix[0][col] = false
      end
    end

    (1...@matrix.length).each do |row|
      (1...@matrix[0].length).each do |col|
        #If element in question is less than the column name
          #then we cannot use that element and we can ask if it is possible
          #to sum without using that element.

        if @set[row] > col
          @matrix[row][col] = @matrix[row - 1][col]

      #Otherwise we can either use that element or not
        #not using it we can get the value from the top
        #Using it we can see if it is possible to sum to col - @set[row]
        # i.e. the leftover sum if we were to use that element will already be
        #calculated

        else
          @matrix[row][col] = @matrix[row - 1][col] ||
            @matrix[row - 1][col - @set[row]]
        end
      end
    end
    @matrix[-1][-1]
  end

  def setup_matrix(target)
    @matrix = Array.new(@set.length) {Array.new(target + 1)}
  end


end
