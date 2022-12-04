require "../../spec_helper"
require "../../../src/aoc2022/days"

describe Aoc2022::Day4 do
  context "Given text input" do
    input = Aoc2022::InMemoryInputReader.new(
      <<-INPUT.strip
        2-4,6-8
        2-3,4-5
        5-7,7-9
        2-8,3-7
        6-6,4-6
        2-6,4-8
      INPUT
    )
    day4 = Aoc2022::Day4.new(input)

    describe "#part1" do
      it "counts how many pairs have 1 complete intersection" do
        day4.part1.should eq(2)
      end
    end

    describe "#scan_range" do
      it "converts raw ranges into range objects" do
        day4.range_into_set("1-4").should eq(Set{1, 2, 3, 4})
      end
    end

    describe "#part2" do
      it "counts how many pair have some overlap" do
        day4.part2.should eq(4)
      end
    end
  end
end
