lib = File.expand_path('lib', __dir__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'inquisition/version'

Gem::Specification.new do |spec|
  spec.name          = 'inquisition'
  spec.version       = Inquisition::VERSION
  spec.authors       = ['Dmitriy Grechukha']
  spec.email         = ['dmitriy.grechukha@gmail.com']

  spec.summary       = 'Code inquisition'
  spec.description   = 'Code inquisition'
  spec.homepage      = 'https://rubygarage.org'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.bindir        = 'exe'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thor', '~> 0.20.3'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'pry', '~> 0.12.2'
  spec.add_development_dependency 'reek', '~> 5.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.4.1'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-lcov'

  spec.add_dependency 'active_record_doctor', '~> 1.6'
  spec.add_dependency 'brakeman', '~> 4.5', '>= 4.5.1'
  spec.add_dependency 'bundler-audit', '~> 0.6.1'
  spec.add_dependency 'fasterer', '~> 0.6.0'
  spec.add_dependency 'lol_dba', '~> 2.1.8'
  spec.add_dependency 'rails_best_practices', '~> 1.19.4'
  spec.add_dependency 'rubocop', '~> 0.72.0'
  spec.add_dependency 'rubocop-performance', '~> 1.4'
  spec.add_dependency 'rubocop-rails', '~> 2.2', '>= 2.2.1'
  spec.add_dependency 'rubocop-rspec', '~> 1.33'
  spec.add_dependency 'rubycritic', '~> 4.1.0'
  spec.add_dependency 'traceroute', '~> 0.8.0'
end
