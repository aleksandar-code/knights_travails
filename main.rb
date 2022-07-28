# frozen_string_literal: true


require 'pry-byebug'
# 4,4 then lower is 2 down 4,2 and 1 down 3,2 for the left for the right
# it's up and not down. next level is 1 down two up or down for either sides, upper levels are same

class Node
  def initialize(value = nil, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end
  attr_accessor :value, :left, :right
end

class Tree
  def initialize(array = [])
    @array = array
    @root = nil
  end

  def root(root)
    @root = root
  end

  def array(array)
    @array = array
  end

  def build_tree(array = nil, start_arr = 0, end_arr = 0, count = 0)
    
    return nil if start_arr > end_arr 
    array = @array.uniq if count == 0 && array.nil?
    count += 1
    start_arr = 0
    end_arr = array.length - 1
    mid_arr = (start_arr + end_arr) / 2
    root = Node.new(array[mid_arr])
    root.left = build_tree(array[start_arr.. mid_arr-1], start_arr, mid_arr-1, count)
    root.right = build_tree(array[mid_arr+1.. end_arr], mid_arr+1, end_arr, count)
    root(root)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  
end

class Board
  def initialize
    @board = Array.new(8) { [*0..7] }
    @array = []
    @knight = nil
    @trees = []
  end
  attr_accessor :board, :array, :trees

  def show_square(row, col)
    p @board[row][col]
  end


  # get position of knight then build a tree to destination square and print the edges.
  # tree printed so start square 0,0 and all possible moves from that tree then the next tree then the next tree
  # until all of the squares are visited then find the shortest path, using BFS and DFS to find the destination
  def knight_moves(starting_square, destination_square)
    @knight = Knight.new(self, starting_square, board)
    @knight.rec(starting_square[0], starting_square[1])
    i = 0
    until (@array[i][0] ==7 && @array[i][1] == 7) do

      # binding.pry
      for moves in @array 
        if moves == destination_square
          puts "#{starting_square}" 
          puts "#{destination_square}" 
          return 
        end
      end
      my_tree = Tree.new(@array)
      my_tree.build_tree
      my_tree.pretty_print
      @knight.rec(@array[i][0], @array[i][1])
      i += 1

    end

    
  end

  def display_board
    board = @board
    board.each_with_index do |row, idx|
      print "row #{idx}: #{row}\n"
    end
  end

  def possible_moves(row, col)
    # binding.pry
    @array << [row, col]
  end
end

# Knight has to return the current possible moves
class Knight
  def initialize(game, start, board)
    @game = game
    @start = start
    @board = board
  end

  def rec(row, col)
    # binding.pry
  steps_row = [
        -2, 
        -2, 
        -1, 
        -1, 
        +2, 
        +2, 
        +1, 
        +1 
      ]

      steps_col = [
        -1,
        +1,
        -2,
        +2,
        -1,
        +1,
        -2,
        +2
      ]
      i = 0
      new_row = nil
      new_col = nil
      # i have my start square and i can probably make a tree of possible moves from that square and
      # then a tree of possible moves from it's children
      for rowx in steps_row
        # binding.pry
        new_row = rowx + row
        
        new_col = steps_col[i] + col
         
        @game.possible_moves(new_row, new_col) if (0..7).include?(new_row) && (0..7).include?(new_col)
          
        i += 1
      end


  end

 

end
board = Board.new

board.display_board

board.knight_moves([0, 0], [7, 7])

p board.array
