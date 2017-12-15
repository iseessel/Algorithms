require 'byebug'

class ContiguousPartitions

  def initialize(partitions)
    @matrix = []
    @contiguous_sums = []
    @partitions = partitions
  end

  def solve(k)
    construct_matrix(k)
    construct_sums

    #Basecase: Just considering the 0th element
    (0...@matrix[0].length).each do |col|
      @matrix[0][col] = {sum: @partitions[0], partitions: []}
    end

    #Basecase: Just considering one partition
    (0...@matrix.length).each do |row|
      @matrix[row][0] = {sum: @contiguous_sums[row], partitions: []}
    end

    #Recursive case

    #Go through each square(left to right first)
    (1...@matrix[0].length).each do |col|
      (1...@matrix.length).each do |row|

        #(Go through each row in the previous col i.e. with one less partition)
        (0..row).each do |row_two|
          current_square = @matrix[row][col]

          square_in_consideration = @matrix[row_two][col - 1]

          #Possible sum is the max of the best way to construct
          #the partition with n elements and k-1 partitions.
          #and the remaining sum

          possible_sum = [square_in_consideration[:sum],
          @contiguous_sums[row] - @contiguous_sums[row_two]].max
          possible_matrix_entry = {
            sum: possible_sum,
            partitions: square_in_consideration[:partitions] + [row_two]
          }

          #If this sum is smaller than the previous sum, replace the sum.
          if current_square.nil?
            @matrix[row][col] = possible_matrix_entry
          else
            @matrix[row][col] = possible_matrix_entry if current_square[:sum] > possible_sum
          end
        end
      end
    end

    @matrix[-1][-1][:partitions]
  end


  def construct_sums
    @partitions.each_with_index do |el, idx|
      if idx == 0
        @contiguous_sums[idx] = el
      else
        @contiguous_sums[idx] = @contiguous_sums[idx - 1] + el
      end
    end
  end

  def construct_matrix(k)
    @matrix = Array.new(@partitions.length) { Array.new(k) }
  end

end
