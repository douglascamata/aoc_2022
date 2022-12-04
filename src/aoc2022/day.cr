module Aoc2022
  abstract class Day
    def initialize(@input_reader : InputReader)
      @input = input_reader.read
    end

    abstract def part1 : Int
    abstract def part2 : Int
  end
end
