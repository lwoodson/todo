require 'set'

module Todo
  module Commands
    @commands = {}

    def self.register(klass)
      base = klass.name.downcase.split("::")[-1]

      (0..base.size).each do |i|
        @commands[base[0..i]] = klass
      end
    end

    def self.lookup(key)
      @commands[key]
    end

    def self.default
      self.lookup('init')
    end
  end
end
