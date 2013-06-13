module Todo
  class Group
    attr_accessor :title, :description
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
      result = title.downcase.gsub(/\s/, '-')
      result.gsub(/[^a-zA-Z0-9\-_]*/, '')
    end
  end
end
