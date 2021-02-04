module Inquisition
  module ActiveRecordDoctor
    class Issue
      def initialize(task, table, column)
        @task = task
        @table = table
        @column = column
      end

      def to_h
        {
          severity: Severity::LOW,
          message: create_message,
          context: task.demodulize
        }
      end

      private

      attr_reader :task, :table, :column

      def create_message
        issue_text = task.demodulize.gsub(/([a-z]+)([A-Z])/, '\1 \2').downcase
        "#{table} has #{issue_text}, details: #{column ? column.join(', ') : 'n/a'}"
      end
    end
  end
end
