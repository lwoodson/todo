module Todo
  class ItemRenderer
    FORMAT = "%-5s%s"
    EMPTY_STR = ''
    SEPARATOR = "\n"
    ITEM_SEPARATOR = "\n\n"
    attr_reader :stream
    def initialize(stream=STDOUT)
      @stream = stream
    end

    def render_output(item_or_items)
      items = Array(item_or_items)
      items.each_with_index do |item, i|
        stream.write(item_as_str(i, item))
        if is_last_item?(items, i)
          stream.write(SEPARATOR)
        else
          stream.write(ITEM_SEPARATOR)
        end
      end
    end

    private
    def is_last_item?(items, index)
      items.size == (index + 1)
    end

    def item_as_str(index, item)
      "".tap do |result|
        result << render_title(index, item)
        item.lines.each do |line|
          result << "\n#{render_line(line)}"
        end
      end
    end

    def render_title(index, item)
      FORMAT % [index_str(index), item.title.upcase]
    end

    def render_line(line)
      FORMAT % [EMPTY_STR, line]
    end

    def format(index, line)
      FORMAT % [index, line]
    end

    def index_str(i)
      "#{i + 1}."
    end
  end
end
