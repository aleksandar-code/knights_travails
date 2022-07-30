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
    # binding.pry
    return nil if start_arr > end_arr 
    array = @array if count == 0 && array.nil?
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

  def insert(value, root = nil, inserted = false)

    evalu = value[0]
    root = @root if root == nil 
    return nil if inserted
    inserted = false
    if evalu > 4
      if root.left == nil
        root.left = Node.new(value)
        inserted = true
      else
        root = root.left
      end
    end
    if evalu < 4
      if root.right == nil
        root.right = Node.new(value)
        inserted = true
      end
      root = root.right
    end
    
    insert(value, root, inserted)
  end
  
end

class Board
  def initialize
    @board = Array.new(8) { [*0..7] }
    @array = []
    @knight = nil
    @tree = nil
    @hashes = []
  end
  attr_accessor :board, :array, :tree, :hashes

  def show_square(row, col)
    p @board[row][col]
  end


  # get position of knight then build a tree to destination square and print the edges.
  # tree printed so start square 0,0 and all possible moves from that tree then the next tree then the next tree
  # until all of the squares are visited then find the shortest path, using BFS and DFS to find the destination
  def knight_moves(starting_square, destination_square)
    @knight = Knight.new(self, starting_square, board)
    i = 0
    @knight.rec(starting_square[0], starting_square[1], i)
    binding.pry
    x = 0
    until (@array[x] == nil) do
      binding.pry
      

    if i == 0 
      array = @array
      @array = []
      curr_square = @array[x].to_s
      @knight.rec(array[x][0], array[x][1], x, curr_square)
      i += 1
    else
      # should use the first hash to recurse
      
      curr_square = @hashes.first
      @knight.rec(array[x][0], array[x][1], x, curr_square)
      x += 1
    end
      


      for moves in array

        if moves == destination_square

          puts "#{starting_square}" 
          puts "[#{array[0][0]}, #{array[0][1]}]"
          puts "#{destination_square}"

          
          return 
        end
      end
      
    end
    i += 1

    
  end

  def display_board
    board = @board
    board.each_with_index do |row, idx|
      print "row #{idx}: #{row}\n"
    end
  end

  def possible_moves(j, i, start, curr_square = nil, row = false, col = false)
    
    if !(row == false) && j!= 7
      @array << [row, col] 
    elsif j == 7 && i == 0 && @hashes[0].nil?
      @array << [row, col]
      binding.pry
      array_name = start.to_s
      array = @array 
      hash = Hash.new 
      hash[array_name] = array
      @hashes = hash
    elsif j == 7 && i > 0 
      @array << [row, col]
      binding.pry
      array_name = curr_square
      array = @array 
      hash = Hash.new 
      hash[array_name] = array
      @hashes << hash
    end
    # @tree.insert([row, col]) if !(@tree.nil?) && !(row == false)
    # here insert it in the tree but at the right level
  end
end

# Knight has to return the current possible moves
class Knight
  def initialize(game, start, board)
    @game = game
    @start = start
    @board = board
  end

  def rec(row, col, i, curr_square = nil)
    
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
      j = 0
      new_row = nil
      new_col = nil

      # i have my start square and i can probably make a tree of possible moves from that square and
      # then a tree of possible moves from it's children
      if row == false
        @game.possible_moves(j, i)
        j += 1
      else
        for rowx in steps_row

          new_row = rowx + row
          
          new_col = steps_col[j] + col
          p j 
          if (0..7).include?(new_row) && (0..7).include?(new_col)
            @game.possible_moves(j, i, @start, curr_square, new_row, new_col) 
          end
          j += 1
            
        end
      end


  end

 

end
board = Board.new

board.display_board

board.knight_moves([3, 3], [4, 3])

p board.array
