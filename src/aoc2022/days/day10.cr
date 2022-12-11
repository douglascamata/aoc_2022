require "../day"

module Aoc2022
  class Day10 < Day
    def part1(debug = false)
      interesting_cycles = [20, 60, 100, 140, 180, 220]
      result = 0
      cpu = CPU.new(@input.split("\n"))
      clock = Clock.new(cpu)
      clock.tick do
        if clock.cycle_counter.in?(interesting_cycles)
          result += cpu.x * clock.cycle_counter
        end
        puts "Interesting cycle: x=#{cpu.x} cycle=#{clock.cycle_counter} loaded=#{cpu.work}" if debug
      end
      result
    end

    def part2
      cpu = CPU.new(@input.split("\n"))
      crt = CRT.new
      clock = Clock.new(cpu, crt)
      clock.tick
      crt.print
    end

    class Clock
      getter cycle_counter

      def initialize(@cpu : CPU, @crt : CRT? = nil)
        @cycle_counter = 1
      end

      def tick
        tick { }
      end

      def tick(&block)
        while @cpu.tick
          @crt.try(&.tick(@cycle_counter, @cpu.x))
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
        return false if @instructions.empty?
        @work = @instructions.shift if @busy_cycles.zero?

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

    class CRT
      @sprite : Array(Char)

      def initialize
        @canvas = Array(Array(Char)).new(6) { Array(Char).new(40, '.') }
        @sprite = Array.new(3, '#') + Array.new(37, '.')
      end

      def tick(cycle_counter : Int32, x : Int32)
        column = ((cycle_counter % 40) - 1) % 40
        line = (cycle_counter - 1) // 40
        return if line > 5

        @canvas[line][column] = @sprite[column] if @sprite[column] == '#'
        @sprite = Array.new(40, '.')
        @sprite[x - 1] = '#'
        @sprite[x] = '#'
        @sprite[x + 1] = '#'
      end

      def print
        String.build do |str|
          str << "\n"
          @canvas.each do |line|
            line.each do |char|
              str << char
            end
            str << "\n"
          end
        end.rstrip
      end
    end
  end
end
