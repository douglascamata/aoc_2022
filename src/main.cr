require "./aoc2022"

if ARGV[0]?.nil?
  puts Aoc2022.run_all
else
  puts Aoc2022.run_day(ARGV[0].to_i)
end
