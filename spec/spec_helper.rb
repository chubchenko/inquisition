# frozen_string_literal: true

require 'bundler/setup'
require 'inquisition'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  # Enable random order in examples
  config.order = :random

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
