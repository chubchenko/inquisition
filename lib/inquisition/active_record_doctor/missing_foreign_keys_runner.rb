require_relative 'runner'
require 'active_record_doctor/tasks/missing_foreign_keys'

module Inquisition
  module ActiveRecordDoctor
    class MissingForeignKeysRunner < ActiveRecordDoctor::Runner
      attr_reader :issues
      TASK = ::ActiveRecordDoctor::Tasks::MissingForeignKeys

      def run
        TASK.run.first.each do |table, column|
          @issues << Issue.new(TASK.name, table, column).to_h.merge(runner: TASK)
        end
      end
    end
  end
end
