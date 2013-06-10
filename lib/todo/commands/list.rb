module Todo
  module Commands
    class List
      attr_reader :parent, :todo_parser, :item_renderer, :dependencies

      def initialize(opts={})
        @parent = opts[:parent] || '.'
        @todo_parser = FileParser.new(parent, Todo::TODO_FILE)
        @item_renderer = ItemRenderer.new(opts[:stream])
        @dependencies = [Init.new(opts)]
      end

      def execute
        dependencies.each{|dep| dep.execute}
      end
    end
  end
end
