$: << 'lib'

require 'todo'
require 'tmpdir'

module Todo
  module Tests
    PARENT = File.join(Dir.tmpdir, 'todo_tests')
    TODO_DIR = File.join(PARENT, Todo::TODO_DIR)
    TODO_FILE = File.join(PARENT, Todo::TODO_FILE)
    WORKING_FILE = File.join(PARENT, Todo::WORKING_FILE)
    DONE_FILE = File.join(PARENT, Todo::DONE_FILE)
    TODO_SYMLINK = File.join(PARENT, Todo::TODO_SYMLINK)

    def test_parent
      PARENT
    end

    def todo_dir
      TODO_DIR
    end

    def todo_file
      TODO_FILE
    end

    def working_file
      WORKING_FILE
    end

    def done_file
      DONE_FILE
    end

    def todo_symlink
      TODO_SYMLINK
    end

    def create_todo_dir
      FileUtils.mkdir_p(TODO_DIR)
    end

    def create_symlink
      FileUtils.ln_s(TODO_FILE, TODO_SYMLINK)
    end

    def write_todo(text)
      File.write(TODO_SYMLINK, text)
    end

    def todo_contents
      File.read(Todo::Tests::TODO_SYMLINK)
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
