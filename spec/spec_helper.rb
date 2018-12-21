# frozen_string_literal: true

require 'bundler/setup'
require 'inquisition'
require 'simplecov'
require 'simplecov-lcov'
require 'undercover'

RSpec.configure do |config|
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
