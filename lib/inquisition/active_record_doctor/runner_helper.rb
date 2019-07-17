require 'rails'
require 'active_record'
require 'active_record_doctor/tasks'

require 'active_record_doctor/tasks/extraneous_indexes'
require 'active_record_doctor/tasks/missing_foreign_keys'
require 'active_record_doctor/tasks/unindexed_deleted_at'
require 'active_record_doctor/tasks/unindexed_foreign_keys'

module Inquisition
  module ActiveRecordDoctor
    module RunnerHelper
      def initialize
        establish_connection
      end

      def call
        issues = []
        executor.run.first.each do |table, column|
          issues << Issue.new(level: Issue::ISSUE_LEVELS[:low],
                              file: "table: #{table}",
                              line: "column(s): #{column.join(', ')}",
                              message: warning_message,
                              runner: self)
        end
        issues
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
