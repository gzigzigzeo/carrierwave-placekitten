# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'carrierwave/placekitten/version'

Gem::Specification.new do |spec|
  spec.name          = "carrierwave-placekitten"
  spec.version       = Carrierwave::PlaceKitten::VERSION
  spec.authors       = ["Victor Sokolov"]
  spec.email         = ["gzigzigzeo@gmail.com"]
  spec.description   = %q{Place kittens for missing images at development environment}
  spec.summary       = %q{Place kittens for missing images at development environment}
  spec.homepage      = "http://github.com/gzigzigzeo/carrierwave-placekitten"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency             "activesupport", ">= 3.0"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "carrierwave"
  spec.add_development_dependency "rspec-rails", ">= 2.6"
  spec.add_development_dependency "mini_magick"
  spec.add_development_dependency "simplecov"
end
