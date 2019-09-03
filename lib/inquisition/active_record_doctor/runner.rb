require 'active_record_doctor/tasks/extraneous_indexes'
require 'active_record_doctor/tasks/missing_foreign_keys'
require 'active_record_doctor/tasks/unindexed_deleted_at'
require 'active_record_doctor/tasks/unindexed_foreign_keys'
require 'active_record_doctor/tasks/undefined_table_references'
require 'active_record_doctor/tasks/missing_unique_indexes'
require 'active_record_doctor/tasks/missing_presence_validation'
require 'active_record_doctor/tasks/missing_non_null_constraint'

module Inquisition
  module ActiveRecordDoctor
    class Runner < ::Inquisition::Runner
      TASKS = {
        ::ActiveRecordDoctor::Tasks::ExtraneousIndexes => :performance,
        ::ActiveRecordDoctor::Tasks::MissingForeignKeys => :bug_risk,
        ::ActiveRecordDoctor::Tasks::MissingNonNullConstraint => :bug_risk,
        ::ActiveRecordDoctor::Tasks::MissingPresenceValidation => :bug_risk,
        ::ActiveRecordDoctor::Tasks::MissingUniqueIndexes => :bug_risk,
        ::ActiveRecordDoctor::Tasks::UndefinedTableReferences => :unused_code,
        ::ActiveRecordDoctor::Tasks::UnindexedDeletedAt => :performance,
        ::ActiveRecordDoctor::Tasks::UnindexedForeignKeys => :performance
      }.freeze

      def call
        TASKS.keys.each do |ard_task|
          ard_task.run.first.each do |table, column|
            @issues << Issue.new(Vulnerability.new(ard_task, table, column).to_h.merge(runner: self))
          end
        end
        @issues
      end
    end
  end
end
