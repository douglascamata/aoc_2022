require "../../spec_helper"
require "../../../src/aoc2022/days"

describe Aoc2022::Day5 do
  context "Given text input" do
    input = Aoc2022::InMemoryInputReader.new(
      <<-INPUT
          [D]
      [N] [C]
      [Z] [M] [P]
       1   2   3

      move 1 from 2 to 1
      move 3 from 1 to 3
      move 2 from 2 to 1
      move 1 from 1 to 2
      INPUT
    )
    day5 = Aoc2022::Day5.new(input)

    describe "#part1" do
      it "moves according to rules" do
        day5.part1.should eq("CMZ")
      end

      it "gives correct result for my input", tags: "real" do
        day5 = Aoc2022::Day5.new(Aoc2022::FileInputReader.new(5))
        day5.part1.should eq("ZRLJGSCTR")
      end
    end

    describe "#part2" do
      it "moves according to rules" do
        day5.part2.should eq("MCD")
      end

      it "gives correct result for my input", tags: "real" do
        day5 = Aoc2022::Day5.new(Aoc2022::FileInputReader.new(5))
        day5.part2.should eq("PRTTGRFPB")
      end
    end
  end
end
