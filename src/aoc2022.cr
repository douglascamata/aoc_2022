require "./aoc2022/*"
require "./time_span"

module Aoc2022
  extend self

  VERSION = "0.1.0"

  def run_all
    DAYS.keys.each { |d| run_day(d) }
  end

  def run_day(day : Int32)
    runner = DAYS[day].new(FileInputReader.new(day))
    part1, part2 = 0, 0
    part1_time = Time.measure do
      part1 = runner.part1
    end
    part2_time = Time.measure do
      part2 = runner.part2
    end

    puts "Day #{day}:\n"
    puts "  Part 1: #{runner.part1} (took #{humanize_time_span(part1_time)})."
    puts "  Part 2: #{runner.part2} (took #{humanize_time_span(part2_time)})."
  end
end
