# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/jira_build_number/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-jira_build_number'
  spec.version       = Fastlane::JiraBuildNumber::VERSION
  spec.author        = 'Tom Elrod'
  spec.email         = 'tom.elrod@gmail.com'

  spec.summary       = 'Insert build number into related jira issues'
  spec.homepage      = "https://github.com/telrod/fastlane-plugin-jira_build_number
  spec.license       = "Apache-2.0"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  # Don't add a dependency to fastlane or fastlane_re
  # since this would cause a circular dependency

  # spec.add_dependency 'your-dependency', '~> 1.0.0'

  spec.add_development_dependency('rest-client')
  spec.add_development_dependency('fastlane')
end
