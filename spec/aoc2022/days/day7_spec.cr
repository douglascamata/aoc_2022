require "../../spec_helper"
require "../../../src/aoc2022/days"

describe Aoc2022::Day7 do
  context "Given text input" do
    input = Aoc2022::InMemoryInputReader.new(
      <<-INPUT
      $ cd /
      $ ls
      dir a
      14848514 b.txt
      8504156 c.dat
      dir d
      $ cd a
      $ ls
      dir e
      29116 f
      2557 g
      62596 h.lst
      $ cd e
      $ ls
      584 i
      $ cd ..
      $ cd ..
      $ cd d
      $ ls
      4060174 j
      8033020 d.log
      5626152 d.ext
      7214296 k
      INPUT
    )
    subject = Aoc2022::Day7.new(input)

    describe "#part1" do
      it "sum top folders by name" do
        subject.part1.should eq(95437)
      end
    end

    describe "#part2" do
      it "find the size of the smallest folder to be deleted that enables the update" do
        subject.part2.should eq(24933642)
      end
    end
  end

  context "Given the real input file" do
    subject = Aoc2022::Day7.new(Aoc2022::FileInputReader.new(7))

    describe "#part1" do
      it "gives correct result for my input", tags: "real" do
        subject.part1.should eq(1350966)
      end
    end

    describe "#part2" do
      it "gives correct result for my input", tags: "real" do
        subject.part2.should eq(6296435)
      end
    end
  end
end
