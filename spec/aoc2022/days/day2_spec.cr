require "../../spec_helper"
require "../../../src/aoc2022/days"

describe Aoc2022::Day2 do
  context "Given text input" do
    input = Aoc2022::InMemoryInputReader.new(
      <<-INPUT.strip
        A Y
        B X
        C Z
      INPUT
    )
    day2 = Aoc2022::Day2.new(input)

    describe "#part1" do
      it "returns the total amount of points of the strategy" do
        day2.part1.should eq 15
      end
    end

    describe "#part2" do
      it "returns the total amount of points following commands" do
        day2.part2.should eq 12
      end

      describe "#play_result" do
        it "recognizes draw" do
          day2.play_command(Aoc2022::Day2::OPONENT_SHAPES["A"], Aoc2022::Day2::Command::DRAW).should eq 4
        end
      end
    end
  end

  context "Given the real input file" do
    subject = Aoc2022::Day2.new(Aoc2022::FileInputReader.new(2))

    describe "#part1" do
      it "gives correct result for my input", tags: "real" do
        subject.part1.should eq(12772)
      end
    end

    describe "#part2" do
      it "gives correct result for my input", tags: "real" do
        subject.part2.should eq(11618)
      end
    end
  end
end
