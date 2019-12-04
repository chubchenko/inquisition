require 'traceroute'

module Inquisition
  module Traceroute
    class Runner < ::Inquisition::Runner
      def call
        unused_routes.map do |route|
          issue_for(message: "Unused route: #{route}")
        end + unreachable_action_methods.map do |action|
          issue_for(message: "Unreachable action method: #{action}")
        end
      end

      private

      def unused_routes
        traceroute.routed_actions - traceroute.defined_action_methods
      end

      def unreachable_action_methods
        traceroute.defined_action_methods - traceroute.routed_actions
      end

      def traceroute
        @traceroute ||= begin
          traceroute = ::Traceroute.new(::Rails.application)
          traceroute.load_everything!
          traceroute
        end
      end

      def issue_for(message:)
        Issue.new(
          path: nil,
          line: nil,
          severity: Severity::LOW,
          message: message,
          category: Category::UNUSED_CODE,
          runner: self,
          warning_type: nil
        )
      end
    end
  end
end
