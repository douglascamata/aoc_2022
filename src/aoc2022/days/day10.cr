require "../day"

module Aoc2022
  class Day10 < Day
    def part1(debug = false)
      interesting_cycles = [20, 60, 100, 140, 180, 220]
      result = 0
      cpu = CPU.new(@input.split("\n"))
      clock = Clock.new(cpu, debug)
      clock.tick do
        if clock.cycle_counter.in?(interesting_cycles)
          result += cpu.x * clock.cycle_counter
        end
        puts "Interesting cycle: x=#{cpu.x} cycle=#{clock.cycle_counter} loaded=#{cpu.work}" if debug
      end
      result
    end

    def part2
    end

    class Clock
      getter cycle_counter

      def initialize(@cpu : CPU)
        @cycle_counter = 1
      end

      def tick
        while @cpu.tick
          @cycle_counter += 1
          yield
        end
      end
    end

    class CPU
      getter x
      getter work
      @instructions : Array(Array(String))
      @work : Array(String)

      def initialize(instructions : Array(String), @x = 1)
        @instructions = instructions.map(&.split(" "))
        @busy_cycles = 0
        @work = [] of String
      end

      def tick : Bool
        @work = @instructions.shift? || [] of String if @busy_cycles.zero?
        return false if @work.nil?
        return false if @work.empty?

        case @work[0]
        when "noop"
          return true
        when "addx"
          if @busy_cycles == 1
            arg = @work[1].to_i
            @x += arg
            @busy_cycles = 0
          else
            @busy_cycles += 1
          end
        else
          raise "Unknown instruction: #{@work}"
        end
        true
      end
    end
  end
end
