require 'factory_bot'

module Inquisition
  module FactoryBot
    class Runner < ::Inquisition::Runner
      def call
        errors = FactoryBotModifiedLinter.new(::FactoryBot.factories, traits: true).call
        errors.each { |error| create_issues(error) }
        @issues
      end

      private

      def create_issues(error)
        @issues << Inquisition::Issue.new(severity: Severity::LOW, path: error.location, runner: self,
                                          category: Category::BUG_RISK, message: error.message, line: nil,
                                          warning_type: nil)
      end
    end
  end
end
