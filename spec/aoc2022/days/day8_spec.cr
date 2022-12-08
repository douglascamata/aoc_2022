require "../../spec_helper"
require "../../../src/aoc2022/days"

describe Aoc2022::Day8 do
  context "Given text input" do
    input = Aoc2022::InMemoryInputReader.new(
      <<-INPUT
      30373
      25512
      65332
      33549
      35390
      INPUT
    )
    subject = Aoc2022::Day8.new(input)

    describe "#part1" do
      it "count trees that are visible from the outside" do
        subject.part1.should eq(21)
      end
    end

    describe "#part2" do
      it "finds the best psosible scenic score" do
        subject.part2.should eq(8)
      end
    end
  end

  context "Given the real input file" do
    subject = Aoc2022::Day8.new(Aoc2022::FileInputReader.new(8))

    describe "#part1" do
      it "gives correct result for my input", tags: "real" do
        subject.part1.should eq(1679)
      end
    end

    describe "#part2" do
      it "gives correct result for my input", tags: "real" do
        subject.part2.should eq(536625)
      end
    end
  end
end
