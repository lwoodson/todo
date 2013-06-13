require 'fileutils'

module Todo
  module Commands
    class Init
      attr_reader :parent, :todo_dir, :todo_file

      def initialize(opts={})
        @parent = opts[:parent] || '.'
        @todo_dir = File.join(@parent, Todo::TODO_DIR)
        @todo_file = File.join(@parent, Todo::TODO_FILE)
      end

      def execute
        FileUtils.mkdir_p(todo_dir) unless Dir.exists?(todo_dir)
        unless File.exists?(todo_file)
          FileUtils.touch(todo_file)
        end
      end
    end
  end
end
