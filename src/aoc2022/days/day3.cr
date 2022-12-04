require "../day"

module Aoc2022
  class Day3 < Day
    struct Rucksack
      @first : String
      @second : String
      property first, second

      def initialize(content : String)
        @first = content[0..(content.size//2) - 1]
        @second = content[content.size//2..]
      end

      def find_duplicate_item
        @first.each_char do |item|
          return Item.new(item) if @second.includes?(item)
        end
        raise "No duplicate item found."
      end

      def items
        (@first + @second).chars.map { |i| Item.new(i) }
      end
    end

    struct Item
      property char

      PRIORITIES = ('a'..'z').to_a + ('A'..'Z').to_a

      def initialize(@char : Char)
      end

      def priority
        index = PRIORITIES.index(@char)
        raise "Didn't find item in list." if index.nil?
        index + 1
      end
    end

    struct Group
      def initialize(@sacks : Array(Rucksack))
      end

      def intersection
        result = @sacks.map { |s| Set.new(s.items) }.reduce do |acc, sack|
          acc & sack
        end
        raise "Unexpected big intersection" if result.size > 1
        return result.first
      end
    end

    def part1 : Int
      @input.split("\n").map(&.strip).map do |raw|
        rucksack = Rucksack.new(raw)
        rucksack.find_duplicate_item.priority
      end.sum
    end

    def part2 : Int
      @input.split("\n").map(&.strip).in_groups_of(3, "").map do |raw_sacks|
        sacks = raw_sacks.map { |s| Rucksack.new(s) }
        group = Group.new(sacks)
        group.intersection.priority
      end.sum
    end
  end
end
