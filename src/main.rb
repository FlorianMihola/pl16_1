#!/usr/bin/env ruby

$LOAD_PATH << '.'

require 'Calculator'
require 'io/console'
require 'optparse'

# defaults

$verbosity = 0
$extended  = false
$buffered  = false

OptionParser.new do |opts|
  opts.banner = "Usage: main.rb [options]"

  opts.on('-v', '--verbose', 'Run verbosely, specify multiple times for more output') do |v|
    $verbosity += 1
  end

  opts.on('-e', '--extended', 'Add command S to print stack') do |s|
    $extended = true
  end

  opts.on('-b', '--buffered', 'buffer input, it will only be read once a newline character is found') do |b|
    $buffered = true
  end
end.parse!

def main
  calc = Calculator.new STDIN, $extended, $verbosity, $buffered

  calc.start
end

main
