#!/usr/bin/env ruby

module Stack
  class Stack
    def initialize
      @arr = Array.new
    end

    def push element
      @arr.unshift element
    end

    def pop
      @arr.shift
    end

    def peek
      @arr[0]
    end

    def to_s
      @arr.to_s
    end

    def copy i
      push @arr[i - 1]
    end

    def delete i
      @arr.delete_at(i - 1)
    end

    def size
      @arr.length
    end

    def empty?
      @arr.length == 0
    end
  end

  def self.new
    Stack.new
  end
end
