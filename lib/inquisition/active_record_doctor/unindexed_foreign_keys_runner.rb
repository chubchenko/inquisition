require_relative 'runner'
require 'active_record_doctor/tasks/unindexed_foreign_keys'

module Inquisition
  module ActiveRecordDoctor
    class UnindexedForeignKeysRunner < ActiveRecordDoctor::Runner
      attr_reader :issues
      TASK = ::ActiveRecordDoctor::Tasks::UnindexedForeignKeys

      def run
        TASK.run.first.each do |table, column|
          @issues << Issue.new(TASK.name, table, column).to_h.merge(runner: TASK)
        end
      end
    end
  end
end
