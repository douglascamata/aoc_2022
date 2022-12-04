require "../../spec_helper"
require "../../../src/aoc2022/days"

describe Aoc2022::Day3 do
  context "Given text input" do
    input = Aoc2022::InMemoryInputReader.new(
      <<-INPUT.strip
        vJrwpWtwJgWrhcsFMMfFFhFp
        jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
        PmmdzqPrVvPwwTWBwg
        wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
        ttgJtRGJQctTZtZT
        CrZsJsPPZsGzwwsLwLmpwMDw
      INPUT
    )
    day3 = Aoc2022::Day3.new(input)

    describe "#part1" do
      it "sums the priorities of all sacks" do
        day3.part1.should eq(157)
      end

      describe Aoc2022::Day3::Item do
        describe "#priority" do
          it "finds the priority of items" do
            Aoc2022::Day3::Item.new('p').priority.should eq(16)
            Aoc2022::Day3::Item.new('L').priority.should eq(38)
          end
        end
      end

      describe Aoc2022::Day3::Rucksack do
        describe "#find_duplicate_item" do
          it "finds duplicate items in both compartments" do
            sack = Aoc2022::Day3::Rucksack.new("vJrwpWtwJgWrhcsFMMfFFhFp")
            sack.first.should eq("vJrwpWtwJgWr")
            sack.second.should eq("hcsFMMfFFhFp")
            sack.find_duplicate_item.should eq(Aoc2022::Day3::Item.new('p'))
          end
        end
      end
    end

    describe "#part2" do
      day3.part2.should eq(70)
    end
  end
end
