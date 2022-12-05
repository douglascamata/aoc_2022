require "../day"
require "string_scanner"

module Aoc2022
  class Day5 < Day
    def part1(@debug = false)
      raw_state, raw_commands = @input.split("\n\n")
      state = parse_state(raw_state)
      raw_commands.split("\n").map(&.strip).each do |raw|
        command = Command.new(raw)
        puts command if @debug
        origin_stack = state[command.source - 1]
        items = origin_stack.delete_at(-command.count, command.count)
        state[command.dest - 1].concat(items.reverse)
      end
      state.map(&.last).join
    end

    def part2(@debug = false)
      raw_state, raw_commands = @input.split("\n\n")
      state = parse_state(raw_state)
      raw_commands.split("\n").map(&.strip).each do |raw|
        command = Command.new(raw)
        puts command if @debug
        origin_stack = state[command.source - 1]
        items = origin_stack.delete_at(-command.count, command.count)
        state[command.dest - 1].concat(items)
        puts state if @debug
      end
      state.map(&.last).join
    end

    FIRST_CHAR_POS = 1
    CHAR_DISTANCE  = 4

    private def parse_state(state : String)
      state_lines = state.split("\n")
      columns = state_lines.delete_at(-1).gsub(" ", "").size
      stacks = Array(Array(Char)).new(columns) { Array(Char).new }
      if @debug
        puts
        puts state
        puts "-----"
      end
      state_lines.reverse.each do |line|
        0.upto(columns - 1) do |column|
          position = FIRST_CHAR_POS + (CHAR_DISTANCE * column)
          entry = line[position]?
          next if entry.nil? || entry == ' '
          puts "Found #{entry} at #{position} for stack #{column}" if @debug
          stacks[column].push(entry)
        end
      end
      puts stacks if @debug
      stacks
    end

    struct Command
      property count, source, dest
      @count : Int32
      @source : Int32
      @dest : Int32

      def initialize(raw : String)
        scanner = StringScanner.new(raw)
        scanner.scan(/move (\d+) from (\d+) to (\d+)/)
        count, source, dest = scanner[1], scanner[2], scanner[3]
        if count.nil? || source.nil? || dest.nil?
          raise "Invalid command: #{raw}"
        end
        @count, @source, @dest = count.to_i, source.to_i, dest.to_i
      end
    end
  end
end
