require 'factory_bot'

module Inquisition
  module FactoryBot
    class Runner < ::Inquisition::Runner
      def call
        ::FactoryBot.find_definitions
        errors = FactoryBotModifiedLinter.new(::FactoryBot.factories, traits: true).call
        errors.each { |error| create_issues(error) }
        @issues
      end

      private

      def create_issues(error)
        @issues << Inquisition::Issue.new(severity: :low, path: error.location, runner: self,
                                          message: error.message, line: nil)
      end
    end
  end
end
