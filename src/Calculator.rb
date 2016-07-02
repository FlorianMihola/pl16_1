#!/usr/bin/env ruby

$LOAD_PATH << '.'

require 'Stack'
require 'io/console'
require 'stringio'

module Calculator
  class Calc
    def initialize input, extended, verbosity, buffered
      @stack  = Stack.new
      @buffer = nil
      @inputs = Stack.new
      @inputs.push input
      @extended = extended
      @slightlyVerbose = verbosity >= 1
      @verbose         = verbosity >= 2
      @veryVerbose     = verbosity >= 3
      @buffered = buffered
    end

    def readChar
      char = nil

      until (not char.nil?) or @inputs.empty?
        if @buffered
          char = @inputs.peek.getc
        else
          char = @inputs.peek.getch
        end

        if char.nil?
          @inputs.pop
        end
      end

      return char
    end

    def readLine
      line = ''

      loop do
        char = readChar
        if ["\n", nil].include? char
          return line
        else
          line += char
        end
      end
    end

    def readInt
      @inputs.push STDIN

      char = readChar

      until char =~ /[0-9]/ # ignore leading non-digits
        char = readChar
      end

      string = ''

      while char =~ /[0-9]/
        string += char
        char = readChar
      end

      @inputs.pop

      # put the first non-digit char back on to the input stream
      @inputs.push StringIO.new char

      puts "read '#{string}' for integer" if @veryVerbose
      return Integer(string)
    end

    def readBlock
      block = ''
      depth = 1

      while depth > 0 do
        char = readChar
        case char
        when ']'
          depth -= 1
        when '['
          depth += 1
        end

        # the only char we should *not* add is the ']'
        # closing the top-most block, in which case
        # depth == 0

        block += char unless depth == 0
      end

      block
    end

    def start
      continue = true
      while continue
        continue = step readChar
      end
    end

    def step char
      puts "step #{char}" if @veryVerbose

      pushBuffer unless char =~ /[0-9]/

      if ['+', '-', '*', '/', '%', '&', '|', '=', '<', '>'].include? char
        puts "binary operator #{char}" if @verbose
        ok = Calculator.binaryOp @stack, char
        unless ok
          abort 'Not enough or wrong type of items on stack'
        end
      elsif char == '~'
        puts 'negate' if @verbose
        @stack.push(@stack.pop * -1)
      elsif char == 'c'
        puts "copy #{@stack.peek}" if @verbose
        @stack.copy @stack.pop
      elsif char == 'd'
        puts "delete #{@stack.peek}" if @verbose
        @stack.delete @stack.pop
      elsif char == 'a'
        puts "apply #{@stack.peek}" if @verbose
        if @stack.size > 0
          a = @stack.pop
          if a.is_a? String
            @inputs.push StringIO.new a
          else
            abort 'Tried to apply Integer'
          end
        else
          abort 'No block on Stack'
        end
      elsif char == 'i'
        puts 'read integer' if @slightlyVerbose
        @stack.push readInt
      elsif char == 'b'
        puts 'read block' if @slightlyVerbose
        @stack.push readLine
      elsif char == 'w'
        if @stack.size > 0
          print "#{@stack.pop} "
        else
          abort 'Stack is empty'
        end
      elsif char == 'x' or char.nil? # exit
        puts 'exit' if @verbose
        return false
      elsif char =~ /[ \t\n]/m # whitespace
        puts "ignoring #{char}" if @veryVerbose
      elsif char =~ /[0-9]/
        if @buffer.nil?
          @buffer = char
        else
          @buffer += char
        end
      elsif char == '['
        @stack.push readBlock
      elsif @extended and char == 'S'
        puts "stack #{@stack}"
      else
        abort "Illegal character '#{char}'"
      end

      puts "  -> #{@stack}" if @verbose and char != 'S'

      true
    end

    def pushBuffer
      puts "push #{@buffer}" if @verbose and not @buffer.nil?
      @stack.push(Integer(@buffer)) unless @buffer.nil?
      @buffer = nil
    end

  end

  def self.new input, extended, verbose, buffered
    Calc.new input, extended, verbose, buffered
  end

  # helpers

  def self.toInt b
    if b
      1
    else
      0
    end
  end

  def self.binaryOp stack, op
    return false if stack.size < 2
    a = stack.pop
    b = stack.pop
    return false unless (both a, b, Numeric or (op == '=' and both a, b, String))

    case op
    when '+'
      stack.push(a + b)
    when '-'
      stack.push(a - b)
    when '*'
      stack.push(a * b)
    when '/'
      stack.push(a / b)
    when '%'
      stack.push(a % b)
    when '='
      stack.push toInt(a == b)
    when '<'
      stack.push toInt(a < b)
    when '>'
      stack.push toInt(a > b)
    end

    true
  end

  def self.both a, b, what
    a.is_a? what and b.is_a? what
  end
end
