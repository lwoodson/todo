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
  end
end
