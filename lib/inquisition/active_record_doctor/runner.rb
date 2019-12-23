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
      TASKS = [
        ::ActiveRecordDoctor::Tasks::ExtraneousIndexes,
        ::ActiveRecordDoctor::Tasks::MissingForeignKeys,
        ::ActiveRecordDoctor::Tasks::MissingNonNullConstraint,
        ::ActiveRecordDoctor::Tasks::MissingPresenceValidation,
        ::ActiveRecordDoctor::Tasks::MissingUniqueIndexes,
        ::ActiveRecordDoctor::Tasks::UndefinedTableReferences,
        ::ActiveRecordDoctor::Tasks::UnindexedDeletedAt,
        ::ActiveRecordDoctor::Tasks::UnindexedForeignKeys
      ].freeze

      def call
        TASKS.each do |ard_task|
          ard_task.run.first.each do |table, column|
            next unless table && column

            @issues << Inquisition::Issue.new(Issue.new(ard_task, table, column).to_h.merge(runner: self))
          end
        end
        @issues
      end
    end
  end
end
