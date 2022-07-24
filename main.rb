# frozen_string_literal: true

# 4,4 then lower is 2 down 4,2 and 1 down 3,2 for the left for the right
# it's up and not down. next level is 1 down two up or down for either sides, upper levels are same

class Board
  def initialize
    @board = Array.new(8) { [*1..8] }
		@knight = Knight.new(@board)
  end
  attr_accessor :board
  
  def show_square(row, col)
    row -= 1
    col -= 1
    p @board[row][col]
  end

  def knight_moves(current_location, destination)

  end
end

class Knight

  def initialize(board)
    @board = board
  end

end
board = Board.new()
board.show_square(8, 8)