require 'byebug'


  def edit_distance(str_one, str_two)
    set_up_matrix(str_one, str_two)

    #Empty string to transform into a string of length n takes n insertions.
    (0..str_two.length).each do |col|
      @matrix[0][col] = col
    end

    #string of length n to transform into an empty string takes n deletions.
    (0..str_one.length).each do |row|
      @matrix[row][0] = row
    end

    (1..str_one.length).each do |row|
      (1..str_two.length).each do |col|
        #If the last character is equal, it is equal to the amount of time it
          #takes to transform the remaining characters.
        if str_one[row - 1] == str_two[col - 1]
          @matrix[row][col] = @matrix[row - 1][col - 1]
        else
          #otherwise it is the max of deletion, insertion, or replacing.
          @matrix[row][col] = 1 + [@matrix[row - 1][col],
            @matrix[row][col - 1],
            @matrix[row - 1][col - 1]
          ].min
        end
      end
    end

    @matrix[-1][-1]
  end

  private

  def set_up_matrix(str_one, str_two)
    @matrix = Array.new(str_one.length + 1) do
      Array.new(str_two.length + 1)
    end
  end


# PURE RECURSIVE SOLUTION:

# def edit_distance(str_one, str_two)
#   if str_one.length == 0 || str_two.length == 0
#     return [str_one.length, str_two.length].max
#   elsif str_one[-1] == str_two[-1]
#     return edit_distance(str_one[0...-1], str_two[0...-1])
#   else
#     return 1 +[
#       edit_distance(str_one[0...-1], str_two),
#       edit_distance(str_one, str_two[0...-1]),
#       edit_distance(str_one[0...-1], str_two[0...-1])
#     ].min
#   end
# end

=begin

  Basecase:
    If either strings are empty, return the length of the larger string.

    f(str_one, str_two) = MAX(str_one.length, str_two.length)
      if str_one.length == 0 || str_two.length == 0

  Recursive Case:
    If the last characters are equal then return that function
      without the last characters.

    f(str_one, str_two) = f(str_one[0..-1],
      str_two[0..-1]) if str_one[-1] == str_two[-1]

    Otherwise it is the 1 + minimum of insertion, deletion, and replacing

    f(str_one, str_two) =

    1 + MIN(
      f(str_one[0..-1], str_two) -> deletion because we are deleting last from str_one
      f(str_one, str_two[0..-1]) -> insertion because when we insert
        we would always insert the last element of string
        two, to string one; just only having to match string two
      f(str_one[0..-1], str_two[0..-1]) -> Replacing because when we replace we would
      always replace the last element of string
      one with the last element of string two, thus there are
      one less letter to replace on both strings.
    )

=end
