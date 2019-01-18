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
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'reek'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov-lcov'
  spec.add_development_dependency 'undercover'
  spec.add_development_dependency 'rubycritic'

  # common
  spec.add_dependency 'awesome_print'        # https://github.com/awesome-print/awesome_print
  spec.add_dependency 'benchmark-ips'        # https://github.com/evanphx/benchmark-ips
  spec.add_dependency 'colorize'             # https://github.com/fazibear/colorize
  spec.add_dependency 'hirb'                 # https://github.com/cldwalker/hirb
  spec.add_dependency 'i18n'
  spec.add_dependency 'overcommit'           # https://github.com/brigade/overcommit
  spec.add_dependency 'pry-byebug'           # https://github.com/deivid-rodriguez/pry-byebug
  spec.add_dependency 'pry-rails'            # https://github.com/rweng/pry-rails
  spec.add_dependency 'pry-rescue'           # https://github.com/ConradIrwin/pry-rescue
  spec.add_dependency 'pry-stack_explorer'   # https://github.com/pry/pry-stack_explorer
  spec.add_dependency 'thor'

  # backend
  spec.add_dependency 'active_record_doctor'
  spec.add_dependency 'brakeman'
  spec.add_dependency 'bullet'
  spec.add_dependency 'bundler-audit'
  spec.add_dependency 'dawnscanner'
  spec.add_dependency 'erb_lint'
  spec.add_dependency 'fasterer'
  spec.add_dependency 'haml_lint'
  spec.add_dependency 'i18n-tasks'
  spec.add_dependency 'lol_dba'
  spec.add_dependency 'railroady'
  spec.add_dependency 'rails-erd'
  spec.add_dependency 'rails_best_practices'
  spec.add_dependency 'reek'
  spec.add_dependency 'rspec-rails'
  spec.add_dependency 'rubocop'
  spec.add_dependency 'rubocop-rspec'
  spec.add_dependency 'rubrowser'
  spec.add_dependency 'ruby-lint'
  spec.add_dependency 'sandi_meter'
  spec.add_dependency 'simplecov'
  spec.add_dependency 'slim_lint'
  spec.add_dependency 'traceroute'
  spec.add_dependency 'yamllint'
end
