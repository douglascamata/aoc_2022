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
    subject = Aoc2022::Day5.new(input)

    describe "#part1" do
      it "moves according to rules" do
        subject.part1.should eq("CMZ")
      end
    end

    describe "#part2" do
      it "moves according to rules" do
        subject.part2.should eq("MCD")
      end
    end
  end

  context "Given the real input file" do
    subject = Aoc2022::Day5.new(Aoc2022::FileInputReader.new(5))

    describe "#part1" do
      it "gives correct result for my input", tags: "real" do
        subject.part1.should eq("ZRLJGSCTR")
      end
    end

    describe "#part2" do
      it "gives correct result for my input", tags: "real" do
        subject.part2.should eq("PRTTGRFPB")
      end
    end
  end
end
