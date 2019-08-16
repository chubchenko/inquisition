ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
require 'byebug'

require File.expand_path('../dummy/config/environment', __FILE__)
require 'rspec/rails'

Dir.glob(File.expand_path('support/**/*.rb', __dir__), &method(:require))

RSpec.configure do |config|
  # redirect console output for unit tests
  # config.before(:all, type: :unit, &:silence_output)

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  # Run examples randomly
  config.order = :random

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
