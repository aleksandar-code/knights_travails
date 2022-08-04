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


class Board
  def initialize
    @board = Array.new(8) { [*0..7] }
    @array = []
    @knight = nil
    @adjacency_list = []
    
  end
  attr_accessor :board, :array, :adjacency_list

  def knight_moves(starting_square, destination_square)
    binding.pry

    
    @board.each_with_index do |row, idx|
        row.each do |col|
            linked_list = LinkedList.new
            linked_list.push([idx, col])
            linked_list.push(rec(idx, col))
            @adjacency_list << linked_list
        end
    end
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

  def rec(row, col)
    
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
    
      for rowx in steps_row
      
        new_row = rowx + row
      
        new_col = steps_col[j] + col
      
        if (0..7).include?(new_row) && (0..7).include?(new_col)
          @game.possible_moves(j, i, @start, curr_square, new_row, new_col) 
      
        end
      
          j += 1
      end

end
board = Board.new

board.display_board

board.knight_moves([0, 0], [1, 2])
