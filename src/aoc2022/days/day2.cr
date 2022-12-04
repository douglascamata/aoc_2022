require "../day"

module Aoc2022
  class Day2 < Day
    OPONENT_SHAPES = {
      "A" => Shape::ROCK,
      "B" => Shape::PAPER,
      "C" => Shape::SCISSORS,
    }
    MY_SHAPES = {
      "X" => Shape::ROCK,
      "Y" => Shape::PAPER,
      "Z" => Shape::SCISSORS,
    }
    WINS = {
      Shape::ROCK     => Shape::SCISSORS,
      Shape::PAPER    => Shape::ROCK,
      Shape::SCISSORS => Shape::PAPER,
    }

    enum Shape
      ROCK     = 1
      PAPER    = 2
      SCISSORS = 3

      def self.from(play : String)
        shape = OPONENT_SHAPES.fetch(play, MY_SHAPES.fetch(play, nil))
        raise "Unknown shape" if shape.nil?
        shape
      end
    end

    enum Command
      WIN
      LOSE
      DRAW

      def self.from(command : String)
        case command
        when "X"
          LOSE
        when "Y"
          DRAW
        when "Z"
          WIN
        else
          raise "Unknown command."
        end
      end
    end

    def part1
      @input.split("\n").map(&.strip).map do |game_line|
        oponent, my = game_line.split(" ").map { |s| Shape.from(s) }
        play(my, oponent) + my.value
      end.sum
    end

    private def play(this : Shape, that : Shape)
      return 3 if this == that
      return 6 if WINS[this] == that
      return 0
    end

    def part2
      @input.split("\n").map(&.strip).map do |game_line|
        raw_oponent, raw_command = game_line.split(" ")
        oponent = Shape.from(raw_oponent)
        command = Command.from(raw_command)
        play_command(oponent, command)
      end.sum
    end

    def play_command(oponent : Shape, command : Command) : Int32
      case command
      when Command::LOSE
        WINS[oponent].value
      when Command::DRAW
        oponent.value + 3
      when Command::WIN
        WINS[WINS[oponent]].value + 6
      else
        0
      end
    end
  end
end
