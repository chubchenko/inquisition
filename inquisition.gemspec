lib = File.expand_path('../lib', __FILE__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'inquisition/version'

Gem::Specification.new do |spec|
  spec.name          = 'inquisition'
  spec.version       = Inquisition::VERSION
  spec.authors       = ['Dmitriy Grechukha']
  spec.email         = ['dmitriy.grechukha@gmail.com']

  spec.summary       = 'Code inquisition'
  spec.description   = 'Code inquisition'
  spec.homepage      = "https://rubygarage.org"
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'

  spec.add_dependency 'awesome_print'        # https://github.com/awesome-print/awesome_print
  spec.add_dependency 'benchmark-ips'        # https://github.com/evanphx/benchmark-ips
  spec.add_dependency 'brakeman'             # https://github.com/presidentbeef/brakeman
  spec.add_dependency 'bullet'               # https://github.com/flyerhzm/bullet
  spec.add_dependency 'bundler-audit'        # https://github.com/rubysec/bundler-audit
  spec.add_dependency 'colorize'             # https://github.com/fazibear/colorize
  spec.add_dependency 'fasterer'             # https://github.com/DamirSvrtan/fasterer
  spec.add_dependency 'hirb'                 # https://github.com/cldwalker/hirb
  spec.add_dependency 'overcommit'           # https://github.com/brigade/overcommit
  spec.add_dependency 'pry-byebug'           # https://github.com/deivid-rodriguez/pry-byebug
  spec.add_dependency 'pry-rails'            # https://github.com/rweng/pry-rails
  spec.add_dependency 'pry-rescue'           # https://github.com/ConradIrwin/pry-rescue
  spec.add_dependency 'pry-stack_explorer'   # https://github.com/pry/pry-stack_explorer
  spec.add_dependency 'railroady'            # https://github.com/preston/railroady
  spec.add_dependency 'rails-erd'            # https://github.com/voormedia/rails-erd
  spec.add_dependency 'rails_best_practices' # https://github.com/flyerhzm/rails_best_practices
  spec.add_dependency 'reek'                 # https://github.com/troessner/reek
  spec.add_dependency 'rubocop'              # https://github.com/bbatsov/rubocop
  spec.add_dependency 'rubycritic'           # https://github.com/whitesmith/rubycritic
  spec.add_dependency 'simplecov'            # https://github.com/colszowka/simplecov
  spec.add_dependency 'traceroute'           # https://github.com/amatsuda/traceroute
end
