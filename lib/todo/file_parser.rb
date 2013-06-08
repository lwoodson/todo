module Todo
  START_MARKER = "\\*"

  class FileParser
    attr_reader :paths

    def initialize(*paths)
      @paths = paths || []
    end

    def items
      [].tap do |items|
        paths.each do |path|
          next unless File.size?(path)
          File.open(path, 'r') do |file|
            file.readlines.each do |line|
              next if just_whitespace?(line)
              if has_start_marker?(line)
                items << Todo::Item.new do |item|
                  item.title = strip_start_marker(line).upcase.strip
                end
              else
                items[-1].append!(line)
              end
            end
          end
        end
      end
    end

    private
    def just_whitespace?(str)
      str =~ /^\s*$/
    end

    def has_start_marker?(str)
      str =~ /#{START_MARKER}/
    end

    def strip_start_marker(str)
      str.gsub(/#{START_MARKER}\s+/, '')
    end
  end
end
