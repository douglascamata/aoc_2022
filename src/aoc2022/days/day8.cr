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
          if i.zero? || j.zero?
            visible_count += 1
            next
          end
          if i == line.size - 1 || j == florest.size - 1
            visible_count += 1
            next
          end

          found = false
          Direction.each do |direction|
            if visible(florest, i, j, direction)
              found = true
              break
            end
          end
          visible_count += 1 if found
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
        los_end = line.index { |tree| tree >= subject }
        case los_end
        when Nil
          los_end = line.size
        else
          los_end += 1
        end
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
      result = Array(Int32).new
      (j - 1).downto(0) do |next_j|
        result.push(florest[i][next_j])
      end
      result
    end

    private def line_right(florest, i, j) : Array(Int32)
      result = Array(Int32).new
      (j + 1).upto(florest.size - 1) do |next_j|
        result.push(florest[i][next_j])
      end
      result
    end

    private def line_above(florest, i, j) : Array(Int32)
      result = Array(Int32).new
      (i - 1).downto(0) do |next_i|
        result.push(florest[next_i][j])
      end
      result
    end

    private def line_below(florest, i, j) : Array(Int32)
      result = Array(Int32).new
      (i + 1).upto(florest.size - 1) do |next_i|
        result.push(florest[next_i][j])
      end
      result
    end
  end
end
