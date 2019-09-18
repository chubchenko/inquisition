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
        ::ActiveRecordDoctor::Tasks::ExtraneousIndexes => Category::PERFORMANCE,
        ::ActiveRecordDoctor::Tasks::MissingForeignKeys => Category::BUG_RISK,
        ::ActiveRecordDoctor::Tasks::MissingNonNullConstraint => Category::BUG_RISK,
        ::ActiveRecordDoctor::Tasks::MissingPresenceValidation => Category::BUG_RISK,
        ::ActiveRecordDoctor::Tasks::MissingUniqueIndexes => Category::BUG_RISK,
        ::ActiveRecordDoctor::Tasks::UndefinedTableReferences => Category::UNUSED_CODE,
        ::ActiveRecordDoctor::Tasks::UnindexedDeletedAt => Category::PERFORMANCE,
        ::ActiveRecordDoctor::Tasks::UnindexedForeignKeys => Category::PERFORMANCE
      }.freeze

      def call
        TASKS.keys.each do |ard_task|
          ard_task.run.first.each do |table, column|
            issues << Inquisition::Issue.new(Issue.new(ard_task, table, column).to_h.merge(runner: self))
          end
        end
        issues
      end
    end
  end
end
