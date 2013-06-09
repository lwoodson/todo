require 'set'

module Todo
  module Commands
    @commands = {}

    def self.register(klass)
      base = klass.name.downcase
      
      (0..base.size).each do |i|
        @commands[base[0..i]] = klass 
      end
    end

    def self.lookup(key)
      @commands[key]
    end
  end
end
