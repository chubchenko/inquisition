require 'rails'
require 'traceroute'
require 'pry'

# require 'rails/console/app'
# require 'rails/console/helpers'
# require 'rails/app_loader'
require 'active_support/dependencies'
# require 'active_support/inflector/methods'

module Inquisition
  module Traceroute
    class Runner < ::Inquisition::Runner
      # ::Bundler.require(*Rails.groups)
      # include Rails::ConsoleMethods
      # include ActiveSupport::Autoload

      class Application < Rails::Application
        traceroute = ::Traceroute.new(Rails.application)
        traceroute.load_everything!
        traceroute.unused_routes
        traceroute.unreachable_action_methods
      end

      def call
      end
    end
  end
end
