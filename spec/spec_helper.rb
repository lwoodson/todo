$: << 'lib'

require 'todo'
require 'tmpdir'
require 'pry'

module Todo
  module Tests
    PARENT = File.join(Dir.tmpdir, 'todo_tests')
    TODO_DIR = File.join(PARENT, Todo::TODO_DIR)
    TODO_FILE = File.join(PARENT, Todo::TODO_FILE)
    TODO_ITEM_DIR = File.join(TODO_DIR, "1")

    def test_parent
      PARENT
    end

    def todo_dir
      TODO_DIR
    end

    def todo_file
      TODO_FILE
    end

    def todo_item_dir
      TODO_ITEM_DIR
    end

    def create_todo_dir
      FileUtils.mkdir_p(TODO_DIR)
    end

    def create_todo_item_dir
      FileUtils.mkdir_p(TODO_ITEM_DIR)
    end

    def create_todo_file
      FileUtils.touch(TODO_FILE)
    end

    def write_todo(text)
      File.write(TODO_FILE, text)
    end

    def todo_contents
      File.read(TODO_FILE)
    end

    def test_join(*elements)
      File.join(PARENT, *elements.map(&:to_s))
    end

    def test_stream
      @stream = StringIO.new
    end

    def stream_contents
      @stream.rewind
      @stream.read
    end
  end
end


RSpec.configure do |config|
  config.before(:each) do
    self.extend Todo::Tests
    FileUtils.rm_rf(Todo::Tests::PARENT)
    FileUtils.mkdir_p(Todo::Tests::PARENT)
  end
end
