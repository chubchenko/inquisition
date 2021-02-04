require_relative 'runner'
require 'active_record_doctor/tasks/missing_non_null_constraint'

module Inquisition
  module ActiveRecordDoctor
    class MissingNonNullConstraintRunner < ActiveRecordDoctor::Runner
      attr_reader :issues
      TASK = ::ActiveRecordDoctor::Tasks::MissingNonNullConstraint

      def run
        TASK.run.first.each do |table, column|
          @issues << Issue.new(TASK.name, table, column).to_h.merge(runner: TASK)
        end
      end
    end
  end
end
