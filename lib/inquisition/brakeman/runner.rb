require 'brakeman'
require 'brakeman/scanner'

module Inquisition
  module Brakeman
    class Runner < ::Inquisition::Runner
      MATCH_TABLE = Hash.new(
        Inquisition::Severity::LOW
      ).update(
        0 => Inquisition::Severity::HIGH, 1 => Inquisition::Severity::MEDIUM
      ).freeze

      def call
        ::Brakeman.run(app_path: '.').warnings.map(&method(:issue_for))
      end

      private

      def issue_for(warning)
        Issue.new(
          severity: MATCH_TABLE[warning.confidence],
          path: warning.relative_path,
          line: warning.line,
          message: warning.message.to_s,
          runner: self
        )
      end
    end
  end
end
