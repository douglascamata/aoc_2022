require "../../spec_helper"
require "../../../src/aoc2022/days"

describe Aoc2022::Day9 do
  context "Given text input" do
    input = Aoc2022::InMemoryInputReader.new(
      <<-INPUT
      R 4
      U 4
      L 3
      D 1
      R 4
      D 1
      L 5
      R 2
      INPUT
    )
    subject = Aoc2022::Day9.new(input)

    describe "#part1" do
      it "counts how many positions the tail visited" do
        subject.part1.should eq(13)
      end
    end

    describe "#part2" do
    end
  end

  context "Given the real input file" do
    subject = Aoc2022::Day9.new(Aoc2022::FileInputReader.new(9))

    describe "#part1" do
      it "gives correct result for my input", tags: "real" do
        subject.part1.should eq(6256)
      end
    end

    describe "#part2" do
      it "gives correct result for my input", tags: "real" do
      end
    end
  end
end
