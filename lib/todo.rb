require "todo/version"
require "todo/item"
require "todo/item_renderer"
require "todo/file_parser"
require "todo/commands"

Dir.glob('lib/todo/commands/*.rb') do |cmd_file|
  load cmd_file
end

module Todo
  # Your code goes here...
end
