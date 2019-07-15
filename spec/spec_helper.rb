require  'ffaker'
require 'simplecov'
require 'inquisition'
require 'json_matchers/rspec'

Dir.glob(File.expand_path('support/**/*.rb', __dir__), &method(:require))

JsonMatchers.schema_root = 'spec/support/schemas'

RSpec.configure do |config|
  config.include CLIHelpModule

  # redirect console output for unit tests
  config.include OutputerHelpModule
  config.before(:all, type: :unit, &:silence_output)

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
