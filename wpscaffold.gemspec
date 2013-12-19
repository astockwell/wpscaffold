# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wpscaffold/version'

Gem::Specification.new do |spec|
  spec.name          = "wpscaffold"
  spec.version       = Wpscaffold::VERSION
  spec.authors       = ["Alex Stockwell"]
  spec.email         = ["astockwell@gmail.com"]
  spec.description   = "Scaffolding engine for Wordpress projects"
  spec.summary       = "Scaffolding engine for Wordpress projects"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
