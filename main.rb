# frozen_string_literal: true
require 'pry-byebug'
class Node
  attr_accessor :data, :neighbors, :visited

  def initialize(data)
    @data = data
    @neighbors = []
    @visited = false
  end

  def add_edge(neighbor)
    @neighbors << neighbor
  end
end

class Graph
  attr_accessor :nodes, :path, :destination_square

  def initialize
    @nodes = []
    @destination_square = nil
    @path = []
  end

  def add_node(value)
    @nodes << Node.new(value)
  end

  def get_node(data)
    @nodes.each do |n|
      return n if data == n.data
    end
  end

  def get_idx(data)
    @nodes.each_with_index do |n, idx|
      return idx if data == n.data
    end
  end

  def get_edge(data)
    start = @nodes[get_idx(data)]
    edge = start.neighbors[0].data
    edge
  end

  def traverse_bfs(starting_square, destination_square)
    @destination_square = destination_square
    moves = 0
    edge = get_edge(starting_square)
    until @path.include?(edge) # until path include an edge of starting square
      root = @nodes[get_idx(starting_square)]
      queue = []
      queue << root
      path.unshift(@destination_square)
      @nodes.each do |node|
        node.visited = false
      end
      bfs(queue)
      moves += 1
    end
    puts "You made it in #{moves} moves!"
    p starting_square
    @path.each { |a| p a }
    @path = []
  end

  def bfs(queue)
    array = []
    until queue.empty?
      current = queue[0]
      unless current.visited
        current.visited = true
        current.neighbors.each do |neighbor|
          queue << neighbor unless neighbor.visited
        end
        array << current.data
        current.neighbors.each do |neighbor|
          if neighbor.data == @destination_square
            @destination_square = array[-1]
            queue = []
          end
        end
      end
      queue = queue[1..] unless queue.empty?
    end
  end
end

# board
class Board
  def initialize
    @board = Array.new(8) { [*0..7] }
    @knight = nil
    @adjacency_list = Graph.new
  end
  attr_accessor :board, :array, :adjacency_list

  def knight_moves(starting_square, destination_square)
    return unless valid_input?(starting_square) && valid_input?(destination_square)

    build
    @adjacency_list.traverse_bfs(starting_square, destination_square)
  end

  def build
    @knight = Knight.new(self)
    add_nodes
    add_edges
  end

  def add_nodes
    @board.each_with_index do |row, idx|
        row.each do |col|
          @adjacency_list.add_node([idx, col])
        end
      end
  end

  def add_edges
    @adjacency_list.nodes.each do |node|
      j = 0
      8.times do
        data = @knight.adjacent(node.data[0], node.data[1], j)
        unless data.nil?
          neigh = @adjacency_list.get_node(data) # get neighbor
          node.add_edge(neigh)
        end
        j += 1
      end
    end
  end

  def display_board
    board = @board
    board.each_with_index do |row, idx|
      print "row #{idx}: #{row}\n"
    end
  end

  def valid_input?(coord)
    return true if (0..7).include?(coord[0]) && (0..7).include?(coord[1])
  end
end

# Knight
class Knight
  def initialize(game)
    @game = game
  end

  def adjacent(row, col, count = nil)
    steps_row = [-2, -2, -1, -1, +2, +2, +1, +1]
    steps_col = [-1, +1, -2, +2, -1, +1, -2, +2]
    count = 0 if count.nil?
    new_row = steps_row[count] + row
    new_col = steps_col[count] + col
    valid_square?(new_row, new_col)
  end

  def valid_square?(row, col)
    return [row, col] if (0..7).include?(row) && (0..7).include?(col)
  end
end
board = Board.new

board.display_board

board.knight_moves([3, 3], [0, 0])
board.knight_moves([0, 0], [3, 3])
board.knight_moves([3, 3], [4, 3])
board.knight_moves([0, 0], [7, 7])
