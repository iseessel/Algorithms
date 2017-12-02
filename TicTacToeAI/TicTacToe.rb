require_relative 'board'

-INFINITY = -Float::INFINITY  #=> InfinityATI
INFINITY = Float::INFINITY  #=> Infinity


class TicTacToeAI #implement alphabeta pruning

  def min_max(board, turn)
    return board.value if board.over?

    best_value, best_move = -INFINITY, nil if turn
    best_value, best_move = INFINITY, nil if !turn

    board.possible_moves.each do |move|
      new_board = board.create_new_board(move)
      if turn #maximizing node
        childrens_best = min_max(new_board, !turn)
        best_value, best_move = childrens_best, move if childrens_best > best_value
        board.best_move = best_move
        return best_value if best_value == 1
      else  #minimizing node
        childrens_best = min_max(new_board, !turn)
        best_value, best_move = childrens_best, move if childrens_best < best_value
        board.best_move = best_move
        return best_value if best_value == -1
      end
    end

    return best_value
  end

end
#
#
# board = Board.new(:x)
# bot = TicTacToeAI.new
#
# bot.min_max(board, true)
#
# start = Time.now
#
# finish = Time.now
#
# p diff = finish - start



# class TicTacToeAI #alphabeta pruning: change the values one by one
#   def min_max(board, turn)
#     return board.value if board.over?
#
#     values = []
#     moves = board.possible_moves.each do |move|
#       new_board = board.create_new_board(move)
#       values << min_max(new_board, !turn)
#     end
#
#     if turn
#       best_value = values.max
#       board.best_move = moves[values.index(best_value)] #Note in the move and value array, the move is paired by its index to the value.
#       return best_value
#     else
#       worst_value = values.min
#       board.best_move = moves[values.index(worst_value)]
#       return worst_value
#     end
#
#   end
# end

    #
    #     new_board = @board.dup
    #     new_board[pos] = @turn
    #     child = TicTacToeNode.new(new_board, new_turn)
    #     child.parent = self
    #     children << child
#     #   end
#     # end
#
#     children
#   end
#
# end


#2) board.possible_moves
#3) Create new board state
