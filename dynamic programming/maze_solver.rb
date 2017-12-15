require 'byebug'

class Maze

  def initialize
    @current_solution
    @maze =   [["L","X", "", "", ""],
               ["", "",  "", "X", ""],
               ["", "X", "", "",  "X"],
               ["", "", "", "",  ""],
               ["", "X","", "X", "X"],
               ["","X", "", "", ""],
               ["", "",  "", "X", ""],
               ["", "X", "X", "X",  "X"],
               ["", "", "", "",  ""],
               ["", "X","", "X", "X"],
               ["L","X", "", "", ""],
               ["", "",  "", "X", ""],
               ["", "X", "", "",  "X"],
               ["", "", "", "",  ""],
               ["", "X","", "X", "X"],
               ["","X", "", "", ""],
               ["", "",  "", "X", ""],
               ["", "X", "X", "X",  "X"],
               ["", "", "", "",  ""],
               ["", "X","", "X", "X"],
               ["L","X", "", "", ""],
              ["", "",  "", "X", ""],
              ["", "X", "", "",  "X"],
              ["", "", "", "",  ""],
              ["", "X","", "X", "X"],
              ["","X", "", "", ""],
              ["", "",  "", "X", ""],
              ["", "X", "X", "X",  "X"],
              ["", "", "", "",  ""],
              ["", "X","", "X", "X"],
              ["L","X", "", "", ""],
              ["", "",  "", "X", ""],
              ["", "X", "", "",  "X"],
              ["", "", "", "",  ""],
              ["", "X","", "X", "X"],
              ["","X", "", "", ""],
              ["", "",  "", "X", ""],
              ["", "X", "X", "X",  "X"],
              ["", "", "", "",  ""],
              ["", "X","", "X", "X"],
              ["", "",  "", "X", ""],
              ["", "X", "", "",  "X"],
              ["", "", "", "",  ""],
              ["", "X","", "X", "X"],
              ["","X", "", "", ""],
              ["", "",  "", "X", ""],
              ["", "X", "X", "X",  "X"],
              ["", "", "", "",  ""],
              ["", "X","", "X", "X"],
              ["L","X", "", "", ""],
              ["", "",  "", "X", ""],
              ["", "X", "", "",  "X"],
              ["", "", "", "",  ""],
              ["", "X","", "X", "X"],
              ["","X", "", "", ""],
              ["", "",  "", "X", ""],
              ["", "X", "X", "X",  "X"],
              ["", "", "", "",  "F"],
              ["", "X","", "X", "X"]
              ]
    @solutions = Array.new(@maze.length) { Array.new(@maze[0].length) }
  end


  def populate_maze_cache(current_pos, possible_solution = [])
   possible_solution << current_pos
    if self[current_pos] == "F"
      @solutions[current_pos[0]][current_pos[1]] = []
      return current_pos
    elsif @solutions[current_pos[0]][current_pos[1]]
      return current_pos
    end

    valid_moves = valid_moves(current_pos) - possible_solution
    valid_moves.each do |move|
      solved = populate_maze_cache(move, possible_solution)
      if solved
        @solutions[current_pos[0]][current_pos[1]] = solved
        return current_pos
      else
        next
      end
    end

    possible_solution.pop
    return false
  end
#We can also keep track of all the nodes we have previously visited!
  def solve(current_pos = [0,0], possible_solution = [])
     possible_solution << current_pos
     return possible_solution if self[current_pos] == "F"
     #This is important in eliminating cycles -> Do not go to a path
      #That you have already visited!
     valid_moves = valid_moves(current_pos) - possible_solution
     valid_moves.each do |move|
      solved = solve(move, possible_solution)
       if solved
         return solved
       else
         next
       end
     end

     possible_solution.pop
     return false
  end

  # def solve(current_pos = [0, 0], prev_pos = [-1, -1])
  #   return [current_pos] if self[current_pos] == "F"
  #   valid_moves = valid_moves(current_pos) - [prev_pos]
  #   valid_moves.each do |move|
  #     solved = solve(move, current_pos)
  #     if solved
  #       return solved.unshift(current_pos)
  #     else
  #       next
  #     end
  #   end
  #
  #   return false
  # end

  def [](pos)
    return unless pos[0].between?(0, @maze.length - 1) &&
      pos[1].between?(0, @maze[0].length - 1)
    @maze[pos[0]][pos[1]]
  end

  def valid_moves(pos)
    valid_moves = []
    move_diffs = [[0, -1],[-1, 0], [1, 0], [0, 1]]
    move_diffs.each do |move_diff|
      new_pos = [pos[0] + move_diff[0], pos[1] + move_diff[1]]
      next unless self[new_pos] == "" || self[new_pos] == "F"
      valid_moves << new_pos
    end

    valid_moves
  end


  #Basecase: if maze[current_pos] == "F" return [current_pos]
  # If no valid moves return false

  #Recursive Case: Go through each of their valid moves and
  # if solve(next_pos) return solve(next_pos).unshift(pos) else NEXT

end
