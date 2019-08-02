require 'simplecov'
require 'inquisition'
require 'rails/all'

ENV['RAILS_ENV'] ||= 'test'

Dir.glob(File.expand_path('support/**/*.rb', __dir__), &method(:require))

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'test_dummy'
)
Dir.glob('spec/dummy/app/models/*.rb').sort.each { |file| require_dependency file }
ActiveRecord::Schema.verbose = false
load 'dummy/db/schema.rb'

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
