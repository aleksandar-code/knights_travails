# frozen_string_literal: true

# 4,4 then lower is 2 down 4,2 and 1 down 3,2 for the left for the right
# it's up and not down. next level is 1 down two up or down for either sides, upper levels are same

class Board
  def initialize
    @board = [

      [0, 1, 2, 3, 4, 5, 6, 7],
      [0, 1, 2, 3, 4, 5, 6, 7],
      [0, 1, 2, 3, 4, 5, 6, 7],
      [0, 1, 2, 3, 4, 5, 6, 7],
      [0, 1, 2, 3, 4, 5, 6, 7],
      [0, 1, 2, 3, 4, 5, 6, 7],
      [0, 1, 2, 3, 4, 5, 6, 7],
      [0, 1, 2, 3, 4, 5, 6, 7],

    ]
		@knight = Knight.new(@board)
  end
  attr_accessor :board
  
  def show_square(row, col)
    
    p @board[row][col]
  end

  def knight_moves(starting_square, destination_square)
    

  end

  def display_board
    board = @board
    board.each_with_index do |row, idx|
      print "row #{idx}: #{row}\n"
    end
  end
end

class Knight

  def initialize(board)
    @board = board
  end

end
board = Board.new()
board.show_square(7, 7)

board.display_board

board.knight_moves([0,0], [1,2])