# -*- encoding: utf-8 -*-
require File.expand_path('../lib/slg-meta/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Sam Livingston-Gray"]
  gem.email         = ["geeksam@gmail.com"]
  gem.description   = %q{Just noodling around, really
  gem.summary       = %q{Metaprogramming challenge from Sam Goldstein at New Relic}}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "slg-meta"
  gem.require_paths = ["lib"]
  gem.version       = SLG::Meta::VERSION

  gem.add_development_dependency 'rspec', '~> 2.11.0'
  gem.add_development_dependency 'nyan-cat-formatter'
end
