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

    def part2(debug = false)
      rope = Rope.new(10, debug)
      @input.split("\n").each do |raw_command|
        raw_command, raw_count = raw_command.split(" ")
        rope.move_head(Direction.parse(raw_command), raw_count.to_i)
      end
      rope.tail_moves.size
    end

    enum Direction
      L
      R
      U
      D
    end

    class Rope
      alias Point = Tuple(Int32, Int32)
      getter tail_moves
      @tail_moves : Set(Point)
      @debug : Bool

      def initialize(size = 2, @debug = false)
        @rope = Array(Point).new(size)
        size.times { @rope << {0, 0} }
        @tail_moves = Set.new([{0, 0}])
      end

      def move_head(dir : Direction, count : Int32)
        count.times do
          @rope[0] = move_point(@rope[0], dir)
          1.upto(@rope.size - 1) do |i|
            process_move(@rope[i - 1], @rope[i]).try do |new_position|
              @rope[i] = new_position
            end
            if i == @rope.size - 1
              @tail_moves.add(@rope[-1])
            end
          end
        end
      end

      private def process_move(moving : Point, previous : Point) : Point?
        new_position : Point? = nil
        move_vector = {moving[0] - previous[0], moving[1] - previous[1]}
        distance = move_vector.map(&.abs).sum
        case {move_vector[0], move_vector[1]}
        when {2, 0}
          new_position = move_point(previous, Direction::R)
        when {-2, 0}
          new_position = move_point(previous, Direction::L)
        when {0, 2}
          new_position = move_point(previous, Direction::U)
        when {0, -2}
          new_position = move_point(previous, Direction::D)
        when {2, 2}
          new_position = {previous[0] + 1, previous[1] + 1}
        when {-2, 2}
          new_position = {previous[0] - 1, previous[1] + 1}
        when {2, -2}
          new_position = {previous[0] + 1, previous[1] - 1}
        when {-2, -2}
          new_position = {previous[0] - 1, previous[1] - 1}
        when {2, 1}, {2, -1}
          new_position = move_point(moving, Direction::L)
        when {-2, 1}, {-2, -1}
          new_position = move_point(moving, Direction::R)
        when {1, 2}, {-1, 2}
          new_position = move_point(moving, Direction::D)
        when {1, -2}, {-1, -2}
          new_position = move_point(moving, Direction::U)
        end
        new_position
      end

      private def move_point(point : Point, dir : Direction) : Point
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
          raise "Unknown direction"
        end
      end
    end
  end
end
