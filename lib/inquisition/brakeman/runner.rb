require 'brakeman'

module Inquisition
  module Brakeman
    class Runner < ::Inquisition::Runner
      def call
        issues = []
        ::Brakeman.run('./').run_checks.warnings.each do |warning|
          issues << Issue.new(level: issue_level(warning.confidence), file: warning.file.relative,
                              line: warning.line, message: warning.message.to_s, runner: self)
        end
        issues
      end

      private

      def issue_level(confidence)
        case confidence
        when 0 then Issue::ISSUE_LEVELS[:high]
        when 1 then Issue::ISSUE_LEVELS[:medium]
        else Issue::ISSUE_LEVELS[:low]
        end
      end
    end
  end
end
