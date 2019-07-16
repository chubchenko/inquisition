require 'rails'
require 'active_record'
require 'active_record_doctor/tasks'
require 'active_record_doctor/tasks/unindexed_foreign_keys'
require 'active_record_doctor/tasks/extraneous_indexes'
require 'active_record_doctor/tasks/missing_foreign_keys'
require 'active_record_doctor/tasks/undefined_table_references'
require 'active_record_doctor/tasks/unindexed_deleted_at'
require 'active_record_doctor/tasks/missing_unique_indexes'
require 'active_record_doctor/tasks/missing_presence_validation'
require 'active_record_doctor/tasks/missing_non_null_constraint'

module Inquisition
  module ActiveRecordDoctor
    class Runner < ::Inquisition::Runner
      def call
        puts 'Inquisition::ActiveRecordDoctor::Runner'
      end
    end
  end
end
