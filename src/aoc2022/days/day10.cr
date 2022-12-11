require "../day"

module Aoc2022
  class Day10 < Day
    def part1
      cpu = CPU.new
      interesting_cycles = [20, 60, 100, 140, 180, 220]
      result = 0
      @input.split("\n").each do |instruction|
        command, *args = instruction.split(" ")
        cpu.process_instruction(command, args) do |cpu|
          if cpu.cycle_counter.in?(interesting_cycles)
            result += cpu.signal_strength
          end
        end
      end
      result
    end

    def part2
    end

    class CPU
      getter cycle_counter

      def initialize(@x = 1)
        @cycle_counter = 0
      end

      def signal_strength
        @x * @cycle_counter
      end

      def process_instruction(instruction : String, args : Array(String))
        case instruction
        when "noop"
          tick
          yield self
        when "addx"
          2.times do
            tick
            yield self
          end
          @x += args[0].to_i
        else
          raise "Unknown instruction: #{instruction}"
        end
      end

      private def tick
        @cycle_counter += 1
      end
    end
  end
end
