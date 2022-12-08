require "../day"

module Aoc2022
  class Day7 < Day
    def part1(debug = false)
      groups = @input.split("$ ").reject(&.empty?).map(&.strip)[1..]
      tree = Dir.new("/")
      process_groups(tree, groups)
      tree.print if debug
      tree.recurse_folders_sizes.tap { |r| puts r if debug }.select do |folder, size|
        size < 100000
      end.map { |folder, size| size }.sum
    end

    def part2(debug = false)
      total_disk_available = 70000000
      disk_for_update = 30000000
      groups = @input.split("$ ").reject(&.empty?).map(&.strip)[1..]
      tree = Dir.new("/")
      process_groups(tree, groups)
      tree.print if debug
      sizes = tree.recurse_folders_sizes
      available_now = total_disk_available - sizes["/"]
      sizes.reject("/").tap { |r| puts r if debug }.select do |folder, size|
        available_now + size > disk_for_update
      end.map { |folder, size| size }.sort.first
    end

    private def process_groups(node : Dir, groups : Array(String))
      return if groups.size.zero?
      group = groups.delete_at(0)
      command, *output = group.split("\n")
      case command
      when "ls"
        output.each do |line|
          dir_or_size, name = line.split(" ")
          case dir_or_size
          when "dir"
            node.add_child(Dir.new(name))
          else
            node.add_child(File.new(name, dir_or_size.to_i))
          end
        end
        process_groups(node, groups)
      else # found "cd something"
        subdir = command.split(" ")[1]
        raise "No subdir" if subdir.nil?

        if subdir == ".." # switch back to parent
          case parent = node.parent
          when Dir
            return process_groups(parent, groups)
          when Nil
            raise "No parent for #{node.name}." if node.parent.nil?
          end
        end

        case subdir_node = node[subdir]
        when Dir
          process_groups(subdir_node, groups)
        else
          raise "Can only process folders."
        end
      end
    end

    class File
      @parent : self | Nil
      getter name, size
      property parent, fullname

      def initialize(@name : String, @size : Int32)
        @fullname = @name
      end

      def print(index : Int32 = 0)
        index.times { print "  " }
        puts "- #{@name} (file, size=#{@size})"
      end
    end

    class Dir < File
      @children : Array(Dir | File)
      getter children

      def initialize(@name : String)
        @children = Array(Dir | File).new
        @size = 0
        @fullname = @name
      end

      def add_child(child : Dir | File)
        child.parent = self
        child.fullname = "#{@fullname}/#{child.name}"
        @children.push(child)
      end

      def dir?
        true
      end

      def print(index : Int32 = 0)
        index.times { print "  " }
        puts "- #{@name} (dir)"
        @children.each(&.print(index + 1))
      end

      def recurse_folders_sizes : Hash(String, Int32)
        result = Hash(String, Int32).new
        size = 0
        @children.each do |child|
          case child
          when Dir
            child_size = child.recurse_folders_sizes
            result.merge!(child_size)
            size += child_size[child.fullname]
          else
            size += child.size
          end
        end
        result[@fullname] = size
        result
      end

      def [](name : String) : Dir | File
        result = @children.find { |c| c.name == name }
        case result
        when Nil
          raise "Didn't find child #{name}"
        else
          result
        end
      end
    end
  end
end
