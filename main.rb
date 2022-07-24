# frozen_string_literal: true

# 4,4 then lower is 2 down 4,2 and 1 down 3,2 for the left for the right
# it's up and not down. next level is 1 down two up or down for either sides, upper levels are same

class Board
  def initialize
    @board = [

      ["00", "01", "02", "03", "04", "05", "06", "07"],
      ["10", "11", "12", "13", "14", "15", "16", "17"],
      ["20", "21", "22", "23", "24", "25", "26", "27"],
      ["30", "31", "32", "33", "34", "35", "36", "37"],
      ["40", "41", "42", "43", "44", "45", "46", "47"],
      ["50", "51", "52", "53", "54", "55", "56", "57"],
      ["60", "61", "62", "63", "64", "65", "66", "67"],
      ["70", "71", "72", "73", "74", "75", "76", "77"],

    ]
		@knight = Knight.new(@board)
  end
  attr_accessor :board
  
  def show_square(row, col)
    
    p @board[row][col]
  end

  def knight_moves(starting_square, destination)
    

  end

  def display_board
    board = @board
    board.each_with_index do |row, idx|
      print "#{row}\n"
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