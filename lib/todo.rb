require "todo/version"
require "todo/item"
require "todo/group"
require "todo/file_parser"
require "todo/commands"

# Dynamically load any commands
Dir.glob('lib/todo/commands/*.rb') do |cmd_file|
  load cmd_file
end

# Dynamically register any commands
Todo::Commands.constants.each do |const_sym|
  const = Todo::Commands.const_get(const_sym)
  next unless const.is_a? Class
  Todo::Commands.register const
end

module Todo
  TODO_DIR = '.todo'
  TODO_FILE = 'TODO'
end
