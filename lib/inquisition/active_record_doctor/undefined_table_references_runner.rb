require_relative 'runner'
require 'active_record_doctor/tasks/undefined_table_references'

module Inquisition
  module ActiveRecordDoctor
    class UndefinedTableReferencesRunner < ActiveRecordDoctor::Runner
      attr_reader :issues
      TASK = ::ActiveRecordDoctor::Tasks::UndefinedTableReferences

      def run
        TASK.run.first.each do |table, column|
          @issues << Issue.new(TASK.name, table, column).to_h.merge(runner: TASK)
        end
      end
    end
  end
end
