require "../../spec_helper"
require "../../../src/aoc2022/days"

describe Aoc2022::Day1 do
  context "Given text input" do
    input = Aoc2022::InMemoryInputReader.new(
      <<-INPUT.strip
        1000
        2000
        3000

        4000

        5000
        6000

        7000
        8000
        9000

        10000
      INPUT
    )
    day1 = Aoc2022::Day1.new(input)

    describe "#part1" do
      it "returns the elf carrying more calories" do
        day1.part1.should eq 24000
      end
    end

    describe "#part2" do
      it "returns the sum of the top 3 calories carriers" do
        day1.part2.should eq 45000
      end
    end
  end
end
