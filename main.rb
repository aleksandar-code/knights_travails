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
    
    array1 = [1]
    x = 0
    # Get my first 2 levels of moves => [{"[3, 3]"=>[[1, 2], [1, 4], [2, 1], [2, 5], [5, 2], [5, 4], [4, 1], [4, 5]]}
    until (array1[x] == nil) do
     
      if x == 0
        array1 = @array
        @array = []
      end
        # should use the first hash to recurse
        
        @array = []
        curr_square = array1[x]
        @knight.rec(array1[x][0], array1[x][1], x, curr_square)
        x += 1
      
      i += 1
    end
    # third level
    x = 0
    @hashes[1..].each do |hash|
      
      hash.each do |k, v|
        
        v.each do |value|
          
          curr_square = value
          @array = []
          @knight.rec(value[0], value[1], x, curr_square)
          x += 1
        end
        x = 0
      end
    end

    @hashes[1..].each do |hash|
      
      hash.each do |k, v|
        
        v.each do |value|
         if value == destination_square
          @hashes[0].each do |key, value1|
            value1.each do |v1|
            puts "yes" if v1 === k || v.include?(v1)
            puts "#{starting_square}"
            puts "#{v1}"
            puts "#{k}"
            puts "#{destination_square}"
            return if v1 == k || v.include?(v1)
            
            end
          end
          
          # how can i define links between my squares?
          
         
         end
        end
        
      end
    end
    binding.pry
    p "p"

  end

  def display_board
    board = @board
    board.each_with_index do |row, idx|
      print "row #{idx}: #{row}\n"
    end
  end

  def possible_moves(j, i, start, curr_square = nil, row = false, col = false)
    if !(row == false) && j == 7
      @array << [row, col]
    elsif !(row == false) && j < 7
      @array << [row, col]
    end
    if j == 7 && @hashes.empty? 
      array_name = start
      array = @array 
      hash = Hash.new 
      hash[array_name] = array
      @hashes << hash
    elsif j == 7 
      array_name = curr_square
      array = @array 
      hash = Hash.new 
      hash[array_name] = array
      @hashes << hash
    end

    p j 
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
       
        @game.possible_moves(j, i, @start, curr_square)
        j += 1
      else
        for rowx in steps_row
          
          new_row = rowx + row
          
          new_col = steps_col[j] + col
          
          if (0..7).include?(new_row) && (0..7).include?(new_col)
            @game.possible_moves(j, i, @start, curr_square, new_row, new_col) 
          
          else
            
            @game.possible_moves(j, i, @start, curr_square)
          
          end
          j += 1
            
        end
      end


  end

 

end
board = Board.new

board.display_board

board.knight_moves([0, 0], [6, 1])

board.display_board