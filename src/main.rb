#!/usr/bin/env ruby

$LOAD_PATH << '.'

require 'Calculator'
require 'io/console'
require 'optparse'

# defaults

$verbosity = 0
$extended  = false
$buffered  = false
$echo      = false
$prelude   = nil
$msgs      = { readInteger: 'read integer',
               readBlock: 'read block'
             }

OptionParser.new do |opts|
  opts.banner = "Usage: main.rb [options]"

  opts.on('-v', '--verbose', 'Run verbosely, specify multiple times for more output') do |v|
    $verbosity += 1
  end

  opts.on('-e', '--echo', 'Echo input') do |e|
    $echo = true
  end

  opts.on('-E', '--extended', 'Add command S to print stack') do |e|
    $extended = true
  end

  #opts.on('-b', '--buffered', 'Buffer input, it will only be read once a newline character is found') do |b|
  #  $buffered = true
  #end

  opts.on('-p', '--prelude STRING', 'Add STRING as first part of input') do |p|
    $prelude = p
  end

  opts.on('-m', '--messageReadInteger STRING', 'Use STRING to ask user for integer input') do |m|
    $msgs[:readInteger] = m
  end

  opts.on('-M', '--messageReadBlock STRING', 'Use STRING to ask user for block input') do |m|
    $msgs[:readBlock] = m
  end

end.parse!

def main
  calc = Calculator.new STDIN, $extended, $verbosity, $buffered, $echo, $msgs

  if $prelude != nil
    calc.addPrelude $prelude
  end

  calc.start
end

main
