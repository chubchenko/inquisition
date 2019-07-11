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

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '~> 12.3.2'
  spec.add_development_dependency 'rspec', '~> 3.8.0'
  spec.add_development_dependency 'json_matchers', '~> 0.11.0'
  spec.add_development_dependency 'rubycritic'
  spec.add_development_dependency 'simplecov-lcov', '~> 0.7.0'

  # common
  spec.add_dependency 'awesome_print', '~> 1.8.0'
  spec.add_dependency 'colorize', '~> 0.8.1'
  spec.add_dependency 'overcommit', '~> 0.49.0'
  spec.add_dependency 'pry-byebug', '~> 3.7.0'
  spec.add_dependency 'pry-rails', '~> 0.3.9'
  spec.add_dependency 'pry-rescue', '~> 1.5.0'
  spec.add_dependency 'pry-stack_explorer', '~> 0.4.9'
  spec.add_dependency 'thor', '~> 0.20.3'
  # We use 2.1.4 because next version forbid use constant name class or module
  spec.add_dependency 'zeitwerk', '2.1.4'
  spec.add_dependency 'tilt', '~> 2.0.9'
  spec.add_dependency 'launchy', '~> 2.4.3'

  # backend
  spec.add_dependency 'active_record_doctor', '~> 1.6.0'
  spec.add_dependency 'brakeman', '~> 4.5.1'
  spec.add_dependency 'bullet', '~> 6.0.1'
  spec.add_dependency 'bundler-audit', '~> 0.6.1'
  spec.add_dependency 'dawnscanner', '~> 1.6.9'
  spec.add_dependency 'erb_lint', '~> 0.0.29'
  spec.add_dependency 'fasterer', '~> 0.6.0'
  spec.add_dependency 'haml_lint', '~> 0.32.0'
  spec.add_dependency 'i18n-tasks', '~> 0.9.29'
  spec.add_dependency 'lol_dba', '~> 2.1.8'
  spec.add_dependency 'railroady', '~> 1.5.3'
  spec.add_dependency 'rails-erd', '~> 1.6.0'
  spec.add_dependency 'rails_best_practices', '~> 1.19.4'
  spec.add_dependency 'reek', '4.8.2'
  spec.add_dependency 'rspec-rails', '~> 3.8.2'
  spec.add_dependency 'rubocop', '0.68.1'
  spec.add_dependency 'rubocop-rspec', '~> 1.33.0'
  spec.add_dependency 'ruby-lint', '~> 2.3.1'
  spec.add_dependency 'simplecov', '~> 0.17.0'
  spec.add_dependency 'slim_lint', '~> 0.17.0'
  spec.add_dependency 'yamllint', '~> 0.0.9'
end
