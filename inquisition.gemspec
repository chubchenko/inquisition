lib = File.expand_path('lib', __dir__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'inquisition/version'

Gem::Specification.new do |spec|
  spec.name          = 'inquisition'
  spec.version       = Inquisition::Version
  spec.authors       = ['Dmitriy Grechukha']
  spec.email         = ['dmitriy.grechukha@gmail.com']

  spec.summary       = 'Code inquisition'
  spec.description   = 'Code inquisition'
  spec.homepage      = 'https://rubygarage.org'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.4.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'pry', '~> 0.12.2'
  spec.add_development_dependency 'reek', '~> 5.0'
  spec.add_development_dependency 'rspec-rails', '~> 3.8', '>= 3.8.2'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.4.1'
  spec.add_development_dependency 'simplecov', '~> 0.17.0'

  spec.add_dependency 'active_record_doctor', '~> 1.6'
  spec.add_dependency 'brakeman', '~> 4.6'
  spec.add_dependency 'bundler-audit', '~> 0.6'
  spec.add_dependency 'bundler-leak', '~> 0.1'
  spec.add_dependency 'factory_bot', '~> 5.0'
  spec.add_dependency 'fasterer', '~> 0.6'
  spec.add_dependency 'i18n-tasks', '~> 0.9'
  spec.add_dependency 'lol_dba', '~> 2.1'
  spec.add_dependency 'rails_best_practices', '~> 1.19'
  spec.add_dependency 'rubocop', '~> 0.74'
  spec.add_dependency 'rubocop-performance', '~> 1.4'
  spec.add_dependency 'rubocop-rails', '~> 2.3'
  spec.add_dependency 'rubocop-rspec', '~> 1.35'
  spec.add_dependency 'rubycritic', '~> 4.1'
  spec.add_dependency 'traceroute', '~> 0.8'
end
