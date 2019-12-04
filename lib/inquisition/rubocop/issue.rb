module Inquisition
  module Rubocop
    class Issue
      LEVELS = {
        refactor: Severity::LOW,
        convention: Severity::LOW,
        warning: Severity::MEDIUM,
        error: Severity::HIGH,
        fatal: Severity::HIGH
      }.freeze

      def initialize(file, offense)
        @file = file
        @offense = offense
      end

      def to_h
        {
          severity: LEVELS[offense.severity.name],
          category: Categorizer.find_category(offense.cop_name),
          path: file,
          message: offense.message,
          line: offense.line,
          warning_type: nil
        }
      end

      private

      attr_reader :file, :offense
    end
  end
end
