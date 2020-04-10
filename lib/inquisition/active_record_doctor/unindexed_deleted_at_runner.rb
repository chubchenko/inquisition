require_relative 'runner'
require 'active_record_doctor/tasks/unindexed_deleted_at'

module Inquisition
  module ActiveRecordDoctor
    class UnindexedDeletedAtRunner < ActiveRecordDoctor::Runner
      attr_reader :issues
      TASK = ::ActiveRecordDoctor::Tasks::UnindexedDeletedAt

      def run
        TASK.run.first.each do |table, column|
          @issues << Issue.new(TASK.name, table, column).to_h.merge(runner: TASK)
        end
      end
    end
  end
end
