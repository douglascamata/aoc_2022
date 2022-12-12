require "../day"
require "big"

module Aoc2022
  class Day11 < Day
    def part1
      monkeys = @input.split("\n\n").map do |raw_monkey|
        parse_monkey(raw_monkey)
      end
      monkeys.each(&.configure_worry_reducer(->(number : Int64) { number // 3 }))
      20.times do
        monkeys.each do |monkey|
          monkey.play(monkeys)
        end
      end
      monkeys.map(&.inspect_count).sort.reverse[0..1].product
    end

    def part2
      monkeys = @input.split("\n\n").map do |raw_monkey|
        parse_monkey(raw_monkey)
      end
      # What's this?
      # This is what prevents the huuuge numbers from getting out of hand.
      # That's the maximum common divisor of all the test divisors. Which means
      # that we can perform the tests "(item % magic) // test" to determine
      # where they are thrown and it will match the result of "number // test".
      # Because we only care about how often monkeys see thrown items, and not
      # the value of the items themselves, this works.
      magic_number = monkeys.map(&.divisible_test).product
      monkeys.each(&.configure_worry_reducer(->(number : Int64) { number % magic_number }))

      10000.times do |i|
        monkeys.each do |monkey|
          monkey.play(monkeys)
        end
      end
      monkeys.map(&.inspect_count).sort.reverse[0..1].map(&.to_big_i).product
    end

    private def parse_monkey(monkey_lines : String) : Monkey
      lines = monkey_lines.split("\n")
      index = lines[0].match(/Monkey (\d+):/).not_nil![1].to_i64
      raw_items = lines[1].match(/Starting items: (.+)/).not_nil![1]
      operation = lines[2].match(/Operation: new = old (.) (.+)/).try do |match|
        Operation.new(match[1], match[2])
      end.not_nil!
      divisible_test = lines[3].match(/Test: divisible by (.+)/).not_nil![1].to_i64
      throw_true = lines[4].match(/If true: throw to monkey (.+)/).not_nil![1].to_i64
      throw_false = lines[5].match(/If false: throw to monkey (.+)/).not_nil![1].to_i64
      Monkey.new(
        index,
        raw_items.split(", ").map(&.to_i64),
        operation,
        divisible_test,
        throw_true,
        throw_false,
      )
    end

    class Monkey
      getter inspect_count, items, divisible_test

      def initialize(
        @index : Int64,
        @items : Array(Int64),
        @operation : Operation,
        @divisible_test : Int64,
        @throw_true : Int64,
        @throw_false : Int64
      )
        @inspect_count = 0
        @worry_reducer = ->(number : Int64) { number }
      end

      def play(monkeys : Array(self))
        @items.each do |item|
          @inspect_count += 1
          new_item = @worry_reducer.call(@operation.execute_with(item))
          if other_monkey = should_throw(new_item)
            monkeys[other_monkey].receive_item(new_item)
          end
        end
        @items.clear
      end

      def receive_item(item : Int64)
        @items.push(item)
      end

      def configure_worry_reducer(worry_reducer : Proc(Int64, Int64))
        @worry_reducer = worry_reducer
      end

      private def should_throw(item : Int64) : Int64
        if (item % @divisible_test).zero?
          return @throw_true
        end
        @throw_false
      end
    end

    class Operation
      def initialize(@operator : String, @operand : String)
      end

      def execute_with(item : Int64) : Int64
        fixed_operand = @operand.gsub("old", item).to_i64
        case @operator
        when "*"
          item * fixed_operand
        else
          item + fixed_operand
        end
      end
    end
  end
end
