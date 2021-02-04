require_relative 'runner'
require 'active_record_doctor/tasks/extraneous_indexes'

module Inquisition
  module ActiveRecordDoctor
    class ExtraneousIndexesRunner < ActiveRecordDoctor::Runner
      attr_reader :issues
      TASK = ::ActiveRecordDoctor::Tasks::ExtraneousIndexes

      def run
        TASK.run.first.each do |table, column|
          @issues << Issue.new(TASK.name, table, column).to_h.merge(runner: TASK)
        end
      end
    end
  end
end
