require 'fileutils'

module Todo
  class Item
    attr_accessor :index, :title, :status, :worker, :description
    attr_reader :children

    def initialize(opts={})
      @index = opts[:index]
      @title = opts[:title]
      @status = opts[:status]
      @worker = opts[:worker]
      @description = opts[:description]
      @children = opts[:children] || []
      validate!
    end

    def ==(other)
      index == other.index and
      title == other.title and
      status == other.status and
      worker == other.worker and
      description == other.description and
      children == other.children
    end

    private
    def validate!
      raise "Index must be positive integer" if index.to_i < 1
    end
  end
end
