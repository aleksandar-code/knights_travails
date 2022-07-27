# frozen_string_literal: true

# 4,4 then lower is 2 down 4,2 and 1 down 3,2 for the left for the right
# it's up and not down. next level is 1 down two up or down for either sides, upper levels are same
class Board
  def initialize
    @board = Array.new(8) { [*0..7] }
    @root = nil
  end
  attr_accessor :board

  def show_square(row, col)
    p @board[row][col]
  end


  # get position of knight then build a tree to destination square and print the edges.
  # tree printed so start square 0,0 and all possible moves from that tree then the next tree then the next tree
  # until all of the squares are visited then find the shortest path, using BFS and DFS to find the destination
  def knight_moves(starting_square, destination_square)
    Knight.new(self, starting_square)

  end

  def display_board
    board = @board
    board.each_with_index do |row, idx|
      print "row #{idx}: #{row}\n"
    end
  end
end

# Knight has to return the current possible moves
class Knight
  def initialize(game, start)
    @game = game
    @start = start
  end

  def rec(row, col)
  steps = [
        [-2, -1], # upper left 1
        [-2, +1], # upper right 1

        [-1, -2], # upper left 2
        [-1, +2], # upper right 2

        [+2, -1], # lower left 1
        [+2, +1], # lower right 1

        [+1, -2], # lower left 2
        [+1, +2], # lower right 2
      ]
      i = 0
      for [rowx, colx] in steps
        new_row = rowx + row
        new_col = colx + col
        possible_moves(new_col, new_row)
        i += 1
      end

  end

  def possible_moves(row, col)

  end

end
board = Board.new

board.display_board

board.knight_moves([3, 3], [1, 2])
