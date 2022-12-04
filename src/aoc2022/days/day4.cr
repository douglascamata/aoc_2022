require "../day"

module Aoc2022
  class Day4 < Day
    def part1 : Int
      @input.split("\n").map(&.strip).count do |raw|
        first, second = raw.split(",").map { |r| range_into_set(r) }
        first.subset_of?(second) || second.subset_of?(first)
      end
    end

    def range_into_set(input : String)
      start, finish = input.split("-").map(&.to_i)
      Set.new((start..finish).to_a)
    end

    def part2 : Int
      @input.split("\n").map(&.strip).count do |raw|
        first, second = raw.split(",").map { |r| range_into_set(r) }
        first.intersects?(second)
      end
    end
  end
end
