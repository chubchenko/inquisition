Dir[File.join(Dir.pwd, 'spec', 'inquisition', 'support', '**', '*.rb')].each { |f| require f }
$LOAD_PATH << File.join(Dir.pwd, 'spec', 'inquisition', 'fixtures')

require 'bundler/setup'
require 'inquisition'
require 'simplecov'
require 'simplecov-lcov'
require 'undercover'
require 'json_matchers/rspec'

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

SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
SimpleCov.formatter = SimpleCov::Formatter::LcovFormatter
SimpleCov.start do
  add_filter(/^\/spec\//) # For RSpec
end

SimpleCov.start
