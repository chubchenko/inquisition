module Inquisition
  module FactoryBot
    class FactoryBotModifiedLinter < ::FactoryBot::Linter
      def call
        invalid_factories.values.flatten
      end
    end
  end
end
