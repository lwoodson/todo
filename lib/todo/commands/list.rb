module Todo
  module Commands
    class List
      attr_reader :parent, :todo_parser, :item_renderer, :dependencies

      def initialize(opts={})
        @parent = opts[:parent] || '.'
        @todo_parser = FileParser.new(File.join(parent, Todo::TODO_FILE))
        @item_renderer = ItemRenderer.new(opts[:stream] || STDOUT)
        @dependencies = [Init.new(opts)]
      end

      def execute
        dependencies.each{|dep| dep.execute}
        items = todo_parser.items
        if items.empty?
          item_renderer.stream.write("There is nothing todo.\n")
        else
          item_renderer.render_output(items)
        end
      end
    end
  end
end
