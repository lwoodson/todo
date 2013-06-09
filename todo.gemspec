# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'todo/version'

Gem::Specification.new do |gem|
  gem.name          = "todo"
  gem.version       = Todo::VERSION
  gem.authors       = ["lwoodson"]
  gem.email         = ["lance@webmaneuvers.com"]
  gem.description   = %q{lightweight management via todo items}
  gem.summary       = %q{using the power of TODO to do management of your poject}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'pry-debugger'
  gem.add_development_dependency 'cane'
  gem.add_dependency 'trollop'
end
