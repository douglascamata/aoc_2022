require "./aoc2022/*"
require "./time_span"

# TODO: Write documentation for `Aoc2022`
module Aoc2022
  extend self

  VERSION = "0.1.0"

  def run_day(day : Int32)
    runner = DAYS[day].new(FileInputReader.new(day))

    puts "Day #{day}:\n"
    ellapsed_time = Time.measure do
      print "  Part 1: #{runner.part1} "
    end
    puts "(took #{humanize_time_span(ellapsed_time)})."

    ellapsed_time = Time.measure do
      print "  Part 2: #{runner.part2} "
    end
    puts "(took #{humanize_time_span(ellapsed_time)})."
  end
end
