begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

APP_RAKEFILE = File.expand_path('spec/dummy/Rakefile', __dir__)
load 'rails/tasks/engine.rake'

require 'bundler/gem_tasks'

Bundler::GemHelper.install_tasks

require 'rspec/core'
require 'rspec/core/rake_task'

desc 'Run all specs in spec directory (excluding plugin specs)'
RSpec::Core::RakeTask.new(spec: 'app:db:test:prepare')

task default: :spec

namespace :assets do
  desc 'Compile all the assets'
  task :compile do
    require 'sprockets'

    assets = Sprockets::Environment.new

    assets.append_path('assets/javascripts')
    assets.append_path('assets/stylesheets')

    assets['application.js'].write_to('public/application.js')
    assets['application.css'].write_to('public/application.css')
  end
end
