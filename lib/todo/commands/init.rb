require 'fileutils'

module Todo
  module Commands
    class Init
      attr_reader :parent, :root, :todo_path, :symlink_path
      def initialize(opts={})
        @parent = opts[:parent] || '.'
        @root = File.join(@parent, '.todo')
        @todo_path = File.join(@root, 'TODO')
        @symlink_path = File.join(@parent, 'TODO')
      end

      def execute
        FileUtils.mkdir_p(root) unless Dir.exists?(root)
        unless File.symlink?(symlink_path)
          if File.exists?(symlink_path)
            FileUtils.mv(symlink_path, todo_path) 
          else
            FileUtils.touch(todo_path)
          end
          FileUtils.ln_s(todo_path, symlink_path)
        end
      end
    end
  end
end
