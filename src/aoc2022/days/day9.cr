require "../day"

module Aoc2022
  class Day9 < Day
    def part1
      rope = Rope.new
      @input.split("\n").each do |raw_command|
        raw_command, raw_count = raw_command.split(" ")
        rope.move_head(Direction.parse(raw_command), raw_count.to_i)
      end
      rope.tail_moves.size
    end

    def part2
    end

    enum Direction
      L
      R
      U
      D
    end

    class Rope
      getter tail_moves
      @head : Tuple(Int32, Int32)
      @tail : Tuple(Int32, Int32)
      @tail_moves : Set(Tuple(Int32, Int32))

      def initialize
        @head = {0, 0}
        @tail = {0, 0}
        @tail_moves = Set.new([{0, 0}])
      end

      def move_head(dir : Direction, count : Int32)
        count.times do
          @head = move_point(@head, dir)
          move_vector = {@head[0] - @tail[0], @head[1] - @tail[1]}
          distance = move_vector.map(&.abs).sum
          case {move_vector[0], move_vector[1]}
          when {2, 0}
            @tail = move_point(@tail, Direction::R)
          when {-2, 0}
            @tail = move_point(@tail, Direction::L)
          when {0, 2}
            @tail = move_point(@tail, Direction::U)
          when {0, -2}
            @tail = move_point(@tail, Direction::D)
          when {2, 1}, {2, -1}
            @tail = move_point(@head, Direction::L)
          when {-2, 1}, {-2, -1}
            @tail = move_point(@head, Direction::R)
          when {1, 2}, {-1, 2}
            @tail = move_point(@head, Direction::D)
          when {1, -2}, {-1, -2}
            @tail = move_point(@head, Direction::U)
          end
          @tail_moves.add(@tail)
        end
      end

      private def move_point(point : Tuple(Int32, Int32), dir : Direction)
        case dir
        when Direction::U
          {point[0], point[1] + 1}
        when Direction::D
          {point[0], point[1] - 1}
        when Direction::R
          {point[0] + 1, point[1]}
        when Direction::L
          {point[0] - 1, point[1]}
        else
          {0, 0}
        end
      end
    end
  end
end
