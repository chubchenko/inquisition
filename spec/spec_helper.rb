ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'

require File.expand_path('dummy/config/environment', __dir__)
require 'rspec/rails'

Dir.glob(File.expand_path('support/**/*.rb', __dir__), &method(:require))

RSpec.configure do |config|
  config.before(:all) do
    Inquisition::Configuration.instance.output = StringIO.new
  end

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
