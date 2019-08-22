require 'rails'
require 'traceroute'

module Inquisition
  module Traceroute
    class Runner < ::Inquisition::Runner
      def call
        @traceroute = ::Traceroute.new(Rails.application)
        @traceroute.load_everything!
        create_issue(unused_routes, 'unused route')
        create_issue(unreachable_action_methods, 'unreachable action method')
        issues
      end

      private

      def unused_routes
        @traceroute.routed_actions - @traceroute.defined_action_methods
      end

      def unreachable_action_methods
        @traceroute.defined_action_methods - @traceroute.routed_actions
      end

      def create_issue(problematic_routes, message)
        problematic_routes.each do |route|
          issues << Issue.new(severity: :low, path: nil, line: nil, runner: self,
                               message: "#{message}: #{route}")
        end
      end
    end
  end
end
