module Todo
  class Item
    attr_accessor :title
    attr_reader :lines

    def initialize
      @lines = lines || []
      yield self if block_given?
    end

    def append!(other_lines)
      @lines += Array(other_lines)
    end

    def ==(other)
      title == other.title and lines == other.lines
    end

    def hash
      lines.hash - title.hash
    end
  end
end
