#!/usr/bin/env ruby

$LOAD_PATH << '.'

require 'Calculator'
require 'io/console'

def main
  calc = Calculator.new STDIN, true, 1, true

  calc.start
end

main
