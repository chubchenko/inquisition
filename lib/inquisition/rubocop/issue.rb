module Inquisition
  module Rubocop
    class Issue
      LEVELS = {
        refactor: :low,
        convention: :low,
        warning: :medium,
        error: :high,
        fatal: :high
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
          line: offense.line
        }
      end

      private

      attr_reader :file, :offense
    end
  end
end
