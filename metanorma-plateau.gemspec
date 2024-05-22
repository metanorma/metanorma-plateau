# coding: utf-8

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "metanorma/plateau/version"

Gem::Specification.new do |spec|
  spec.name          = "metanorma-plateau"
  spec.version       = Metanorma::Plateau::VERSION
  spec.authors       = ["Ribose Inc."]
  spec.email         = ["open.source@ribose.com"]

  spec.summary       = "Metanorma for MLIT Project PLATEAU (private)"\
  spec.description   = <<~DESCRIPTION
    Metanorma standards authoring environment for MLIT Project PLATEAU.

    WARNING: Usage of this software is restricted to authorized users of
    MLIT Project PLATEAU.
  DESCRIPTION

  spec.homepage      = "https://github.com/metanorma/metanorma-plateau"
  spec.license       = "No-License"
  spec.metadata      = { "github_repo" => "ssh://github.com/metanorma/metanorma-plateau" }

  spec.bindir        = "bin"
  spec.require_paths = ["lib"]
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features|bin|.github)/}) \
    || f.match(%r{Rakefile|bin/rspec})
  end
  spec.test_files = `git ls-files -- {spec}/*`.split("\n")
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")

  spec.add_dependency "metanorma-jis", "~> 0.2.7"
  spec.add_dependency "pubid"

  spec.add_development_dependency "debug"
  spec.add_development_dependency "equivalent-xml", "~> 0.6"
  spec.add_development_dependency "guard", "~> 2.14"
  spec.add_development_dependency "guard-rspec", "~> 4.7"
  spec.add_development_dependency "iev", "~> 0.3.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.6"
  spec.add_development_dependency "rubocop", "~> 1.5.2"
  spec.add_development_dependency "sassc", "2.4.0"
  spec.add_development_dependency "simplecov", "~> 0.15"
  spec.add_development_dependency "timecop", "~> 0.9"
  spec.add_development_dependency "vcr", "~> 6.1.0"
  spec.add_development_dependency "webmock"
end
