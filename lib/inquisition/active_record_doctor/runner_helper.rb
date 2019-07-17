require 'rails'
require 'active_record'
require 'active_record_doctor/tasks'

require 'active_record_doctor/tasks/extraneous_indexes'
require 'active_record_doctor/tasks/missing_foreign_keys'
require 'active_record_doctor/tasks/unindexed_deleted_at'
require 'active_record_doctor/tasks/unindexed_foreign_keys'

# these modules need Rails.application
# -------------------------------------
# require 'active_record_doctor/tasks/undefined_table_references'
# require 'active_record_doctor/tasks/missing_unique_indexes'
# require 'active_record_doctor/tasks/missing_presence_validation'
# require 'active_record_doctor/tasks/missing_non_null_constraint'

module Inquisition
  module ActiveRecordDoctor
    module RunnerHelper
      def perform(active_record_doctor_module)
        connect_db
        issues = []
        active_record_doctor_module.run.first.each do |table, column|
          issues << Issue.new(level: Issue::ISSUE_LEVELS[:low],
                              file: "table: #{table}",
                              line: "column(s): #{column.join(', ')}",
                              message: warning_message,
                              runner: self)
        end
        issues
      end

      def connect_db
        db_config = load_db_config
        ActiveRecord::Base.establish_connection(
          adapter: db_config['adapter'],
          host: db_config['host'],
          username: db_config['username'],
          password: db_config['password'],
          database: db_config['database']
        )
      end

      def load_db_config
        YAML::load(IO.read('config/database.yml'))[Rails.env]
      end

      def warning_message
        NotImplementedError
      end
    end
  end
end
