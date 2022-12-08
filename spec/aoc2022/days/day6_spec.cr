require "../../spec_helper"
require "../../../src/aoc2022/days"

describe Aoc2022::Day6 do
  context "Given text input" do
    describe "#part1" do
      inputs = [
        "bvwbjplbgvbhsrlpgdmjqwftvncz",
        "nppdvjthqldpwncqszvftbrmjlhg",
        "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg",
        "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw",
      ]

      it "finds the chars processed before first packet marker" do
        results = [5, 6, 10, 11]
        inputs.zip(results).each do |input, result|
          reader = Aoc2022::InMemoryInputReader.new(input)
          Aoc2022::Day6.new(reader).part1.should eq(result)
        end
      end
    end
    describe "#part2" do
      inputs = [
        "mjqjpqmgbljsphdztnvjfqwrcgsmlb",
        "bvwbjplbgvbhsrlpgdmjqwftvncz",
        "nppdvjthqldpwncqszvftbrmjlhg",
        "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg",
        "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw",
      ]

      it "finds the chars processed before first message marker" do
        results = [19, 23, 23, 29, 26]
        inputs.zip(results).each do |input, result|
          reader = Aoc2022::InMemoryInputReader.new(input)
          Aoc2022::Day6.new(reader).part2.should eq(result)
        end
      end
    end
  end

  context "Given the real input file" do
    subject = Aoc2022::Day6.new(Aoc2022::FileInputReader.new(6))

    describe "#part1" do
      it "gives correct result for my input", tags: "real" do
        subject.part1.should eq(1282)
      end
    end

    describe "#part2" do
      it "gives correct result for my input", tags: "real" do
        subject.part2.should eq(3513)
      end
    end
  end
end
