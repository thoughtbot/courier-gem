# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'courier/version'

Gem::Specification.new do |spec|
  spec.name                  = "courier"
  spec.version               = Courier::VERSION
  spec.authors               = ["Klaas Pieter Annema"]
  spec.email                 = ["kpa@thoughtbot.com"]

  spec.summary               = %q{Interact with the Courier API}
  spec.description           = %q{Courier is a service making push notifications easy}
  spec.homepage              = "https://courier.thoughtbot.com"
  spec.license               = "MIT"

  spec.files                 = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir                = "exe"
  spec.executables           = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths         = ["lib"]
  spec.required_ruby_version = "~> 2.2"

  spec.add_dependency "faraday_middleware", "~> 0.8"
  spec.add_dependency "activesupport", "~> 4.2"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "webmock", "~> 1.24"
end
