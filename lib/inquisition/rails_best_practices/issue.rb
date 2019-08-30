module Inquisition
  module RailsBestPractices
    class Issue
      def initialize(error)
        @error = error
      end

      def to_h
        {
          category: Categorizer.find_category(error.type),
          severity: :low,
          message: error.message,
          path: error.short_filename,
          line: error.line_number.to_i
        }
      end

      private

      attr_reader :error
    end
  end
end
