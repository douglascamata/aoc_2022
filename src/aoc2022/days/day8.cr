require "../day"

module Aoc2022
  class Day8 < Day
    def part1
      florest = Array(Array(Int32)).new
      @input.split("\n") do |line|
        florest.push(line.split("").map(&.to_i))
      end
      visible_count = 0
      florest.each_with_index do |line, i|
        line.each_with_index do |tree, j|
          if on_edge(florest, i, j)
            visible_count += 1
            next
          end
          Direction.values.find do |direction|
            visible(florest, i, j, direction)
          end.try { visible_count += 1 }
        end
      end
      visible_count
    end

    def part2
      florest = Array(Array(Int32)).new
      @input.split("\n") do |line|
        florest.push(line.split("").map(&.to_i))
      end
      florest.map_with_index do |line, i|
        line.map_with_index do |tree, j|
          scenic_score(florest, i, j)
        end
      end.flatten.sort.last
    end

    enum Direction
      LEFT
      RIGHT
      UP
      DOWN
    end

    private def scenic_score(florest, i, j)
      return 0 if on_edge(florest, i, j)
      subject = florest[i][j]
      lines = [
        line_below(florest, i, j),
        line_above(florest, i, j),
        line_left(florest, i, j),
        line_right(florest, i, j),
      ]
      lines.map do |line|
        line.index { |tree| tree >= subject }.try { |i| i + 1 } || line.size
      end.product
    end

    private def on_edge(florest, i, j) : Bool
      return true if i.zero?
      return true if j.zero?
      return true if i == florest.size - 1
      return true if j == florest.size - 1
      false
    end

    private def visible(florest, i, j, direction : Direction)
      subject = florest[i][j]
      case direction
      when Direction::UP
        return line_above(florest, i, j).all? { |other| other < subject }
      when Direction::DOWN
        return line_below(florest, i, j).all? { |other| other < subject }
      when Direction::LEFT
        return line_left(florest, i, j).all? { |other| other < subject }
      when Direction::RIGHT
        return line_right(florest, i, j).all? { |other| other < subject }
      end
    end

    private def line_left(florest, i, j) : Array(Int32)
      Array(Int32).new.tap do |result|
        (j - 1).downto(0) do |next_j|
          result.push(florest[i][next_j])
        end
      end
    end

    private def line_right(florest, i, j) : Array(Int32)
      Array(Int32).new.tap do |result|
        (j + 1).upto(florest.size - 1) do |next_j|
          result.push(florest[i][next_j])
        end
      end
    end

    private def line_above(florest, i, j) : Array(Int32)
      Array(Int32).new.tap do |result|
        (i - 1).downto(0) do |next_i|
          result.push(florest[next_i][j])
        end
      end
    end

    private def line_below(florest, i, j) : Array(Int32)
      Array(Int32).new.tap do |result|
        (i + 1).upto(florest.size - 1) do |next_i|
          result.push(florest[next_i][j])
        end
      end
    end
  end
end
