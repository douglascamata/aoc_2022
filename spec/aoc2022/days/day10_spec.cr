require "../../spec_helper"
require "../../../src/aoc2022/days"

describe Aoc2022::Day10 do
  context "Given text input" do
    input = Aoc2022::InMemoryInputReader.new(
      <<-INPUT.strip
      addx 15
      addx -11
      addx 6
      addx -3
      addx 5
      addx -1
      addx -8
      addx 13
      addx 4
      noop
      addx -1
      addx 5
      addx -1
      addx 5
      addx -1
      addx 5
      addx -1
      addx 5
      addx -1
      addx -35
      addx 1
      addx 24
      addx -19
      addx 1
      addx 16
      addx -11
      noop
      noop
      addx 21
      addx -15
      noop
      noop
      addx -3
      addx 9
      addx 1
      addx -3
      addx 8
      addx 1
      addx 5
      noop
      noop
      noop
      noop
      noop
      addx -36
      noop
      addx 1
      addx 7
      noop
      noop
      noop
      addx 2
      addx 6
      noop
      noop
      noop
      noop
      noop
      addx 1
      noop
      noop
      addx 7
      addx 1
      noop
      addx -13
      addx 13
      addx 7
      noop
      addx 1
      addx -33
      noop
      noop
      noop
      addx 2
      noop
      noop
      noop
      addx 8
      noop
      addx -1
      addx 2
      addx 1
      noop
      addx 17
      addx -9
      addx 1
      addx 1
      addx -3
      addx 11
      noop
      noop
      addx 1
      noop
      addx 1
      noop
      noop
      addx -13
      addx -19
      addx 1
      addx 3
      addx 26
      addx -30
      addx 12
      addx -1
      addx 3
      addx 1
      noop
      noop
      noop
      addx -9
      addx 18
      addx 1
      addx 2
      noop
      noop
      addx 9
      noop
      noop
      noop
      addx -1
      addx 2
      addx -37
      addx 1
      addx 3
      noop
      addx 15
      addx -21
      addx 22
      addx -6
      addx 1
      noop
      addx 2
      addx 1
      noop
      addx -10
      noop
      noop
      addx 20
      addx 1
      addx 2
      addx 2
      addx -6
      addx -11
      noop
      noop
      noop
      INPUT
    )
    subject = Aoc2022::Day10.new(input)

    describe "#part1" do
      it "sums the signal strength in interesting cycles (20th, 60th, 100th, 140th, 180th, and 220th)" do
        subject.part1.should eq(13140)
      end
    end

    describe "#part2" do
      it "print the CRT correctly at the end" do
        subject.part2.strip.should eq(
          <<-INPUT.strip
          ##..##..##..##..##..##..##..##..##..##..
          ###...###...###...###...###...###...###.
          ####....####....####....####....####....
          #####.....#####.....#####.....#####.....
          ######......######......######......####
          #######.......#######.......#######.....
          INPUT
        )
      end
    end
  end

  context "Given the real input file" do
    subject = Aoc2022::Day10.new(Aoc2022::FileInputReader.new(10))

    describe "#part1" do
      it "gives correct result for my input", tags: "real" do
        subject.part1.should eq(14560)
      end
    end

    describe "#part2" do
      it "gives correct result for my input", tags: "real" do
        subject.part2.strip.should eq(
          <<-INPUT.strip
          ####.#..#.###..#..#.####.###..#..#.#####
          #....#.#..#..#.#..#.#....#..#.#..#....#.
          ###..##...#..#.####.###..#..#.#..#...#..
          #....#.#..###..#..#.#....###..#..#..#...
          #....#.#..#.#..#..#.#....#....#..#.#...#
          ####.#..#.#..#.#..#.####.#.....##..####.
          INPUT
        )
      end
    end
  end
end
