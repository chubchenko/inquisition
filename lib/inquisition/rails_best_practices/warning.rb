module Inquisition
  module RailsBestPractices
    class Warning
      def initialize(error)
        @error = error
      end

      def to_h
        {
          path: error.short_filename,
          line: error.line_number.to_i,
          severity: Severity::LOW,
          message: error.message.capitalize,
          category: Categorizer.find_category(error.type)
        }
      end

      private

      attr_reader :error
    end
  end
end
