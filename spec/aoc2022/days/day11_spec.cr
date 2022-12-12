require "../../spec_helper"
require "../../../src/aoc2022/days"

describe Aoc2022::Day11 do
  context "Given text input" do
    input = Aoc2022::InMemoryInputReader.new(
      <<-INPUT.strip
      Monkey 0:
        Starting items: 79, 98
        Operation: new = old * 19
        Test: divisible by 23
          If true: throw to monkey 2
          If false: throw to monkey 3

      Monkey 1:
        Starting items: 54, 65, 75, 74
        Operation: new = old + 6
        Test: divisible by 19
          If true: throw to monkey 2
          If false: throw to monkey 0

      Monkey 2:
        Starting items: 79, 60, 97
        Operation: new = old * old
        Test: divisible by 13
          If true: throw to monkey 1
          If false: throw to monkey 3

      Monkey 3:
        Starting items: 74
        Operation: new = old + 3
        Test: divisible by 17
          If true: throw to monkey 0
          If false: throw to monkey 1
      INPUT
    )
    subject = Aoc2022::Day11.new(input)

    describe "#part1" do
      it "works" do
        subject.part1.should eq(10605)
      end
    end

    describe "#part2" do
      it "works" do
        subject.part2.should eq(2713310158)
      end
    end
  end

  context "Given the real input file" do
    subject = Aoc2022::Day11.new(Aoc2022::FileInputReader.new(11))

    describe "#part1" do
      it "gives correct result for my input", tags: "real" do
        subject.part1.should eq(90882)
      end
    end

    describe "#part2" do
      it "gives correct result for my input", tags: "real" do
        subject.part2.should eq(30893109657)
      end
    end
  end
end
