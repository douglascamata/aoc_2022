module Aoc2022
  abstract class InputReader
    abstract def read : String
  end

  class InMemoryInputReader < InputReader
    def initialize(@input : String)
    end

    def read : String
      @input
    end
  end

  class FileInputReader < InputReader
    def initialize(@day : Int32)
    end

    def read : String
      File.read("src/aoc2022/days/day#{@day}.txt")
    end
  end
end
