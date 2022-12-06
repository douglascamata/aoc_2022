require "../../spec_helper"
require "../../../src/aoc2022/days"

describe Aoc2022::Day5 do
  context "Given text input" do
    input_results = [
      {input: "bvwbjplbgvbhsrlpgdmjqwftvncz", result: 5},
      {input: "nppdvjthqldpwncqszvftbrmjlhg", result: 6},
      {input: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", result: 10},
      {input: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", result: 11},
    ]

    describe "#part1" do
      input_results.each do |data|
        input = Aoc2022::InMemoryInputReader.new(data[:input])
        Aoc2022::Day6.new(input).part1.should eq(data[:result])
      end
    end
    describe "#part2" do
    end
  end

  context "Given the real input file" do
    # subject = Aoc2022::Day6.new(Aoc2022::FileInputReader.new(6))

    describe "#part1" do
      it "gives correct result for my input", tags: "real" do
      end
    end

    describe "#part2" do
      it "gives correct result for my input", tags: "real" do
      end
    end
  end
end
