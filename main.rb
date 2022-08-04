# frozen_string_literal: true

require 'pry-byebug'

# 4,4 then lower is 2 down 4,2 and 1 down 3,2 for the left for the right
# it's up and not down. next level is 1 down two up or down for either sides, upper levels are same

class LinkedList
    #is_empty?: return true if the linked list is empty
    def is_empty?
        if @head == nil
            return true
        else
            return false
        end
    end
    attr_accessor :head
    #push: given a data, add a new node in the end
    def push(data)
        if self.is_empty?
            @head = Node.new(data)
        else
            current_node = @head
            new_node = Node.new(data)
            while current_node.next != nil
                current_node = current_node.next
            end
            current_node.next = new_node
        end
    end
    #unshift: add a new node in the front
    def unshift(data)
        if self.is_empty?
            @head = Node.new(data)
        else
            curr_head = Node.new(data)
            curr_head.next = @head
            @head = curr_head
        end
    end
    #pop: remove the last node and return it
    def pop
        if self.is_empty?
            return "This list is currently empty"
        else
            current_node = @head
            while current_node.next.next != nil
                current_node = current_node.next
            end
            last_node = current_node.next
            current_node.next = nil
        end
        last_node
    end
    #shift: remove the first node and return it
    def shift
        if self.is_empty?
            return "This list is currently empty"
        else
            curr_head = @head
            new_head = @head.next
            @head.next = nil
            @head = new_head
        end
        curr_head
    end
    #size: return the length of linked list
    def size
        if self.is_empty?
            count = 0
        else
            count = 1
            current_node = @head
            while current_node.next != nil
                current_node = current_node.next
                count += 1
            end
        end
        count
    end
    #pretty_print: print the current linked list as an array
    def pretty_print
        array = []
        current_node = @head
        if self.is_empty?
            return array
        else
            while current_node.next != nil
                array << current_node.data
                current_node = current_node.next
            end
            array << current_node.data
       end
       array
    end
    #clear: clear the whole linked list
    def clear
        @head = nil
    end

end

class Node
    
    attr_accessor :data, :next

    def initialize(data, next_node = nil)
        @data = data
        @next = next_node
    end

end

class Graph
    def initialize
        @alist = Array.new()
    end
    attr_accessor :alist

    def add_node(row, col)
        linked_list = LinkedList.new
        linked_list.push([row, col])
        @alist << linked_list
    end

    def add_edge(src, dst)
        current_list = @alist[src]

        dst_node = @alist[dst].head

        current_list.push(dst_node)

    end
# so first i'll have to get in the square 0,0 check if 3,3 is an edge, if not then check the children of the children of 0,0.
# use DFS AND BFS, i want to take the children of my starting square 0,0 and then link them via paths to 3,3

    # def dfs_bfs
    #     check_edge()
    #     count_edges()
    # end

    # data gives access to the nodes in a linked list SO if my dst_node isn't in the current linked list, i search in curr_node.next.data
    # next gives acess to a adjacent node SO if my dst_node isn't equal to current node i look up the next node.

    # 0,0
    # Or i enter linkedlist 0,0; i check if the next node is equal dst node if not i then check if it is in his children i queue his children
    # then i check if the next node is equal to dst_node if not i then check if it is in his children i queue his children
    # 1,2 2,1
    # Then i check the next node if it is equal to my dst node if not then i check in his children and i queue his children
    # Then i check the next node if it is equal to my dst node if not then i check in his children and i queue his children
    # and repeat this until i found 2 path to my dst_node as 0,0 gives to 2 moves (1,2 and 2,1)

    # Result i checked 0,0 1,2 2,1 and queued the children of 1,2 and 2,1

    def count_edges(src, dst, edges = 0)
        binding.pry
        current_list = @alist[src]
        dst_node = @alist[dst].head
        curr_node = current_list.head
        edges = 0 
        until curr_node == false
            if curr_node.data == dst_node
                return edges + 1
            end
            edges += 1
            if !(curr_node.nil?)
                curr_node = curr_node.next
                src = search_node(curr_node.data.data)
                p check_edge(src, dst)
            else
                curr_node = false
            end
        end
        
    end

    def check_edge(src, dst)
        current_list = @alist[src]
        dst_node = @alist[dst].head
        curr_node = current_list.head
        until curr_node == nil
            if curr_node.data == dst_node
                return true
            end
            curr_node = curr_node.next
        end
        return false
    end

    def search_node(data)

        @alist.each_with_index do |list, idx|
            if list.head.data == data
                return idx
            end
        end
    end

    def print_()
        for current_list in @alist
            curr_node = current_list.head
            i = 0
            until curr_node == nil
                print "#{curr_node.data} -> " if i == 0
                print "#{curr_node.data.data} -> " if i > 0
                i += 1
                curr_node = curr_node.next
            end
            print "\n"
        end
    end

end

class Board
  def initialize
    @board = Array.new(8) { [*0..7] }
    @knight = nil
    @adjacency_list = Graph.new
    
  end
  attr_accessor :board, :array, :adjacency_list

  def knight_moves(starting_square, destination_square)
    binding.pry

    @knight = Knight.new(self, starting_square, @board)
    # add nodes.
    @board.each_with_index do |row, idx|
        row.each do |col|
            @adjacency_list.add_node(idx, col)
        end
    end
   
    # add edges
    
        @board.each_with_index do |row, idx|
            row.each do |col|
                j = 0
                8.times do 

                    data = @knight.rec(idx, col, j)
                    if !(data == nil)
                        dst = @adjacency_list.search_node(data)  # get index of the dst
                        data = [idx, col]
                        src = @adjacency_list.search_node(data)  # get index of the dst
                        @adjacency_list.add_edge(src, dst)
                        
                    end
                    j += 1
                end
            end
        end
    

    starting_square = @adjacency_list.search_node(starting_square)

    destination_square = @adjacency_list.search_node(destination_square)

    p @adjacency_list.count_edges(starting_square, destination_square)
    p @adjacency_list.print_
    binding.pry

  end
  
  def display_board
    board = @board
    board.each_with_index do |row, idx|
      print "row #{idx}: #{row}\n"
    end
  end


end

class Knight
  def initialize(game, start, board)
    @game = game
    @start = start
    @board = board
  end

  def rec(row, col, j = nil)
    
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

      j = 0 if j == nil
      new_row = nil
      new_col = nil
    
     
      
      new_row = steps_row[j] + row
      
      new_col = steps_col[j] + col
      
      if (0..7).include?(new_row) && (0..7).include?(new_col)
        return [new_row, new_col]
      end
      
    end

end
board = Board.new

board.display_board

board.knight_moves([0, 0], [3, 3])
