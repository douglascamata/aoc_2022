require "../day"

module Aoc2022
  class Day7 < Day
    def part1(debug = false)
      groups = @input.split("$ ").reject(&.empty?).map(&.strip)
      groups.delete_at(0)
      tree = Node.new("/")
      process_groups(tree, groups)
      tree.print if debug
      tree.recurse_folders_sizes.tap { |r| puts r if debug }.select do |folder, size|
        size < 100000
      end.map { |folder, size| size }.sum
    end

    def part2(debug = false)
      total_disk_available = 70000000
      disk_for_update = 30000000
      groups = @input.split("$ ").reject(&.empty?).map(&.strip)
      groups.delete_at(0)
      tree = Node.new("/")
      process_groups(tree, groups)
      tree.print if debug
      sizes = tree.recurse_folders_sizes
      available_now = total_disk_available - sizes["/"]
      sizes.reject("/").tap { |r| puts r if debug }.select do |folder, size|
        available_now + size > disk_for_update
      end.map { |folder, size| size }.sort.first
    end

    private def process_groups(node : Node, groups : Array(String))
      return if groups.size.zero?
      group = groups.delete_at(0)
      command, *output_lines = group.split("\n")
      case command
      when "ls"
        output_lines.each do |line|
          dir_or_size, name = line.split(" ")
          case dir_or_size
          when "dir"
            node.add_child(Node.new(name))
          else
            node.add_child(Node.new(name, dir_or_size.to_i))
          end
        end
        process_groups(node, groups)
      else # found "cd something"
        subdir = command.split(" ")[1]
        raise "No subdir" if subdir.nil?

        if subdir == ".."
          parent = node.parent
          case parent
          when Nil
            raise "No parent for #{node.name}." if node.parent.nil?
          when Node
            return process_groups(parent, groups)
          end
        end

        subdir_node = node[subdir]
        raise "Didn't see subdir node: #{subdir}" if subdir_node.nil?
        process_groups(subdir_node, groups)
      end
    end

    class Node
      @children : Array(self)
      @parent : self | Nil
      @type : Symbol
      getter name, children, size
      property parent, fullname

      def initialize(@name : String)
        @children = Array(self).new
        @size = 0
        @type = :dir
        @fullname = @name
      end

      def initialize(@name : String, @size : Int32)
        @children = Array(self).new
        @type = :file
        @fullname = @name
      end

      def add_child(child : self)
        child.parent = self
        child.fullname = "#{@fullname}/#{child.name}"
        @children.push(child)
      end

      def print(index : Int32 = 0)
        index.times { print "  " }
        puts "- #{@name} (#{dir_or_size})"
        @children.each do |child|
          if child.dir?
            child.print(index + 1)
          else
            (index + 1).times { print "  " }
            puts "- #{child.name} (file, size=#{child.size})"
          end
        end
      end

      private def dir_or_size
        return "dir" if dir?
        "#{@size}"
      end

      def recurse_folders_sizes : Hash(String, Int32)
        result = Hash(String, Int32).new
        size = 0
        @children.each do |child|
          if child.dir?
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

      def dir?
        @type == :dir
      end

      def file?
        !dir
      end

      def [](name : String)
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
