require 'rails'
require 'traceroute'
require 'pry'

module Inquisition
  module Traceroute
    class Runner < ::Inquisition::Runner
      def call
        binding.pry
        load_environment
        @traceroute = ::Traceroute.new(Rails.application)
        @traceroute.load_everything!
        create_issue(unused_routes, 'unused route')
        create_issue(unreachable_action_methods, 'unreachable action method')
        binding.pry
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
          issues << Issue.new(level: Issue::LEVELS[:low], file: nil, line: nil, runner: self,
                               message: "#{message}: #{route}")
        end
      end

      def load_environment
        require "#{Dir.pwd}/config/environment"
      end
    end
  end
end
