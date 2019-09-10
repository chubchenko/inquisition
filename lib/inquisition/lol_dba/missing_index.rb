module Inquisition
  module LolDba
    class Columns
      def initialize(columns)
        @columns = Array(columns)
      end

      def to_s
        @columns.map do |column|
          "`#{column}`"
        end.join(', ')
      end
    end

    class MissingIndex
      def initialize(table:, columns:)
        @table = table
        @columns = Columns.new(columns)
      end

      def to_h
        {
          path: nil,
          line: nil,
          severity: Severity::LOW,
          message: "The following column(s) #{columns} from the `#{table}` table probably should be indexed",
          category: Category::PERFORMANCE
        }
      end

      private

      attr_reader :table, :columns
    end
  end
end
