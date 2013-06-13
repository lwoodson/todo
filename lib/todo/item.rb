require 'fileutils'

module Todo
  class Item
    TODO_STATUS = 'todo'
    WORKING_STATUS = 'working'
    DONE_STATUS = 'done'
    STATUSES = [TODO_STATUS, WORKING_STATUS, DONE_STATUS]
    attr_accessor :title, :worker, :description
    attr_reader :children, :status, :index

    def initialize(opts={})
      @index = opts[:index]
      @title = opts[:title]
      @status = opts[:status] || TODO_STATUS
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

    STATUSES.each do |status|
      define_method("#{status}!") do
        @status = status
      end

      define_method("#{status}?") do
        @status == status
      end
    end

    def index=(index)
      raise "Unable to coerce #{index} to int}" unless index.respond_to?(:to_i) 
      raise "#{index} not positive integer" if index.to_i < 1
      @index = index.to_i
    end

    private
    def validate!
      raise "Status must be #{STATUSES.join(', ')}" unless STATUSES.include?(status)
    end
  end
end
