require "../day"

module Aoc2022
  class Day1 < Day
    def part1
      biggest_calories_sum(1)
    end

    def part2
      biggest_calories_sum(3)
    end

    private def biggest_calories_sum(count : Int32)
      @input.split("\n\n").map(&.strip).map do |elf_line|
        elf_line.split("\n").map(&.to_i).sum
      end.sort.reverse[0..count - 1].sum
    end
  end
end
