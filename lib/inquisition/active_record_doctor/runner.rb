require 'rails'
require 'active_record'
require 'active_record_doctor/tasks'
require 'active_record_doctor/tasks/extraneous_indexes'
require 'active_record_doctor/tasks/missing_foreign_keys'
require 'active_record_doctor/tasks/unindexed_deleted_at'
require 'active_record_doctor/tasks/unindexed_foreign_keys'

module Inquisition
  module ActiveRecordDoctor
    class Runner < ::Inquisition::Runner
      def call
        establish_connection
        issues = []
        ::ActiveRecordDoctor::Tasks.all.each do |ard_module|
          ard_module.run.first.each do |table, column|
            issues << Issue.new(level: Issue::LEVELS[:low], file: nil, line: nil, runner: self,
                                message: create_message(ard_module, table, column))
          end
        end
        issues
      end

      def create_message(ard_module, table, column)
        issue_text = ard_module.to_s.split('::').last.split(/(?=[A-Z])/).map(&:downcase).join(' ')
        "Table #{table} has #{issue_text} in column(s) #{column.join(', ')}"
      end

      def establish_connection
        ActiveRecord::Base.establish_connection(load_db_config)
      end

      def load_db_config
        YAML.load(IO.read('config/database.yml'))[Rails.env]
      end
    end
  end
end
