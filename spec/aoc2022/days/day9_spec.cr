require "../../spec_helper"
require "../../../src/aoc2022/days"

describe Aoc2022::Day9 do
  context "Given text input" do
    describe "#part1" do
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

      it "counts how many positions the tail visited" do
        subject.part1.should eq(13)
      end
    end

    describe "#part2" do
      input = Aoc2022::InMemoryInputReader.new(
        <<-INPUT
        R 5
        U 8
        L 8
        D 3
        R 17
        D 10
        L 25
        U 20
        INPUT
      )
      subject = Aoc2022::Day9.new(input)

      context "when the rope is longer" do
        it "counts how many positions the tail visited" do
          subject.part2.should eq(36)
        end
      end
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
        subject.part2.should eq(2665)
      end
    end
  end
end
