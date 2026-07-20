# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'that_language/client/version'

Gem::Specification.new do |spec|
  spec.name          = "that_language-client"
  spec.version       = ThatLanguage::Client::VERSION
  spec.authors       = ["Patrick Helm"]
  spec.email         = ["me@patrick-helm.de"]

  spec.summary       = %q{API client for ThatLanguage.}
  spec.description   = %q{Drop-in replacement for the that_language gem that answers each call over HTTP against a that_language-service instance, instead of loading wordlists locally.}
  spec.homepage      = "https://github.com/Deradon/that_language-client"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 3.1"

  spec.metadata = {
    "homepage_uri"          => spec.homepage,
    "source_code_uri"       => spec.homepage,
    "bug_tracker_uri"       => "#{spec.homepage}/issues",
    "rubygems_mfa_required" => "true"
  }

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # ostruct stopped being a default gem in Ruby 4.0, so it must be declared
  # explicitly. DetailsQuery wraps each result in an OpenStruct; without this
  # the gem fails to load on 4.x with a bare LoadError.
  spec.add_dependency "ostruct", "~> 0.6"

  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.13"
  spec.add_development_dependency "rspec-its", "~> 2.0"
  spec.add_development_dependency "rubocop", "~> 1.88"
  spec.add_development_dependency "webmock", "~> 3.25"
end
