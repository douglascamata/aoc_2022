require "ecr"

class DayTemplate
  def initialize(@number : Int32)
  end

  ECR.def_to_s "templates/day.ecr"
end

class DaySpecTemplate
  def initialize(@number : Int32)
  end

  ECR.def_to_s "templates/day_spec.ecr"
end

def generate_day(number : Int32)
  rendered_day = DayTemplate.new(number).to_s
  File.write("src/aoc2022/days/day#{number}.cr", rendered_day)
  File.write("src/aoc2022/days/day#{number}.txt", "input for day #{number}")

  rendered_day_spec = DaySpecTemplate.new(number).to_s
  File.write("spec/aoc2022/days/day#{number}_spec.cr", rendered_day_spec)
end

if ARGV[0]?
  generate_day(ARGV[0].to_i)
end
