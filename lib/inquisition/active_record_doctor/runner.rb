require 'active_record_doctor/tasks'
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
      def call
        ::ActiveRecordDoctor::Tasks.all.each do |ard_task|
          ard_task.run.first.each do |table, column|
            @issues << Issue.new(severity: :low, path: nil, line: nil, runner: self,
                                 message: create_message(ard_task, table, column))
          end
        end
        @issues
      end

      private

      def create_message(ard_task, issue_object, details)
        issue_text = ard_task.to_s.split('::').last.split(/(?=[A-Z])/).map(&:downcase).join(' ')
        "#{issue_object} has #{issue_text}, details: #{details ? details.join(', ') : 'n/a'}"
      end
    end
  end
end
