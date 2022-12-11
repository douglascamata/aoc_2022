require "../day"

module Aoc2022
  class Day6 < Day
    def part1
      chars_before_unique_moving_window(@input.chars, 4)
    end

    def part2
      chars_before_unique_moving_window(@input.chars, 14)
    end

    private def chars_before_unique_moving_window(container : Enumerable, window_size : Int32)
      before_packet_start = 0
      moving_window(@input.chars, window_size) do |chars|
        return before_packet_start + window_size if chars.uniq.size == window_size
        before_packet_start += 1
      end
      0
    end

    private def moving_window(container : Enumerable, window_size : Int32)
      container.map_with_index do |item, index|
        container[index, window_size]?.try do |window_elements|
          yield window_elements
        end
      end
    end
  end
end
