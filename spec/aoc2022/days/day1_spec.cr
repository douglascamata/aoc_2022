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
    subject = Aoc2022::Day1.new(input)

    describe "#part1" do
      it "returns the elf carrying more calories" do
        subject.part1.should eq 24000
      end
    end

    describe "#part2" do
      it "returns the sum of the top 3 calories carriers" do
        subject.part2.should eq 45000
      end
    end
  end

  context "Given the real input file" do
    subject = Aoc2022::Day1.new(Aoc2022::FileInputReader.new(1))

    describe "#part1" do
      it "gives correct result for my input", tags: "real" do
        subject.part1.should eq(69177)
      end
    end

    describe "#part2" do
      it "gives correct result for my input", tags: "real" do
        subject.part2.should eq(207456)
      end
    end
  end
end
