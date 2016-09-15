#!/usr/bin/env ruby

$LOAD_PATH << '.'

require 'Calculator'
require 'io/console'
require 'optparse'

# defaults

$verbosity = 0
$extended  = false
$buffered  = false
$prelude   = nil

OptionParser.new do |opts|
  opts.banner = "Usage: main.rb [options]"

  opts.on('-v', '--verbose', 'Run verbosely, specify multiple times for more output') do |v|
    $verbosity += 1
  end

  opts.on('-e', '--extended', 'Add command S to print stack') do |s|
    $extended = true
  end

  opts.on('-b', '--buffered', 'Buffer input, it will only be read once a newline character is found') do |b|
    $buffered = true
  end

  opts.on('-p', '--prelude STRING', 'Add STRING as first part of input') do |p|
    $prelude = p
  end
end.parse!

def main
  calc = Calculator.new STDIN, $extended, $verbosity, $buffered

  if $prelude != nil
    calc.addPrelude $prelude
  end

  calc.start
end

main
