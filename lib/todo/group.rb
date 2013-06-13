module Todo
  class Group
    attr_accessor :title, :description, :parent_dir
    def initialize
      @items = []
    end

    def <<(item)
      @items << item
      item.index = @items.size
    end

    def items
      (@items + []).freeze
    end

    def filename
      raise "group has no title" unless title
      result = title.downcase.gsub(/\s/, '-')
      result.gsub(/[^a-zA-Z0-9\-_]*/, '')
    end

    def path
      raise "group has no parent_dir" unless parent_dir
      File.join(parent_dir, filename)
    end
  end
end
