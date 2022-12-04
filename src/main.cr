require "./aoc2022"

if ARGV[0]?
  puts Aoc2022.run_day(ARGV[0].to_i)
else
  puts Aoc2022.run_all
end
