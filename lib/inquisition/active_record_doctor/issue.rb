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
          path: nil,
          line: nil,
          message: create_message,
          category: Runner::TASKS[task],
          context: task_constant
        }
      end

      private

      attr_reader :task, :table, :column

      def create_message
        issue_text = task_constant.split(/(?=[A-Z])/).map(&:downcase).join(' ')
        "#{table} has #{issue_text}, details: #{column ? column.join(', ') : 'n/a'}"
      end

      def task_constant
        task.to_s.split('::').last
      end
    end
  end
end
