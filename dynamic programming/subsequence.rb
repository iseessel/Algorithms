require 'byebug'

class Subsequence

  def initialize(str_one, str_two)
    @str_one = str_one
    @str_two = str_two
    @matrix = Array.new(str_one.length + 1) {
      Array.new(str_two.length + 1)
    }
  end

  #BOTTOM UP WITH DYNAMIC PROGRAMMING

  def subsequence
    setup_basecase

    (1...@matrix.length).each do |row|
      (1...@matrix[0].length).each do |col|
        substring_one = @str_one[0...row]
        substring_two = @str_two[0...col]
        if substring_one[-1] == substring_two[-1]
          @matrix[row][col] = @matrix[row - 1][col  - 1] + substring_one[-1]
        else
          if @matrix[row - 1][col].length > @matrix[row][col - 1].length
            @matrix[row][col] = @matrix[row - 1][col]
          else
            @matrix[row][col] = @matrix[row][col - 1]
          end
        end
      end
    end

    @matrix[-1][-1]
  end

  #
  # #TOP DOWN WITH MEMOIZING
  def subsequence(str_one = @str_one, str_two = @str_two)
    #If either strings are zero then the subsequence is 0
    if str_one.length == 0 || str_two.length == 0
      0

    #If its already been memoized, don't search again for it!

    elsif @matrix[str_one.length - 1][str_two.length - 1]
      return @matrix[str_one.length - 1][str_two.length - 1]

      #If the last letters are the same, then the subsequence is
      # equal to 1 + subsequnce minus each of the last letters

    elsif str_one[-1] == str_two[-1]
      @matrix[str_one.length - 1][str_two.length - 1] =
      1 + subsequence(str_one[0...-1], str_two[0...-1])

      #If the last letters are NOT the same, then s("ab", "bc") =
        # [s("ab", "b"), s("a", "bc")] because
      # we are decrementing each by one  and will eventually find all
      # permutations of choosing letters(i.e. eventually if there are common letters
      #then our previous recursive case will find it.)


    else
      @matrix[str_one.length - 1][str_two.length - 1] =
      [subsequence(str_one, str_two[0...-1]),
        subsequence(str_one[0...-1], str_two)
        ].max
    end
  end

  def setup_basecase
    (0...@matrix[0].length).each do |col|
      @matrix[0][col] = ""
    end

    (0...@matrix.length).each do |row|
      @matrix[row][0] = ""
    end

  end
end
