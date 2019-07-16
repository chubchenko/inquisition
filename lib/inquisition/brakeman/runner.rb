require 'brakeman'

module Inquisition
  module Brakeman
    class Runner < ::Inquisition::Runner
      def call
        issues = []
        ::Brakeman.run('./').run_checks.warnings.each do |warning|
          issues << Issue.new(level: '', file: warning.file.relative, line: warning.line,
                              message: warning.message.to_s, runner: self)
        end
        issues
      end
    end
  end
end
