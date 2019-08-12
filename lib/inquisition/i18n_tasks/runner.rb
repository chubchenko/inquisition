require 'i18n/tasks'

module Inquisition
  module I18nTasks
    class Runner < ::Inquisition::Runner
      def call
        base_task = ::I18n::Tasks::BaseTask.new
        parse_data_errors([base_task.missing_keys, base_task.unused_keys])
        @issues
      end

      private

      def parse_data_errors(errors)
        errors.each do |error|
          error.keys.each { |key, node| define_node_files_for_issue(key, node) }
        end
        @issues.flatten!
      end

      def define_node_files_for_issue(key, node)
        data_file = node.data[:occurrences]
        @issues << (data_file ? data_file.map { |file| create_issue(key, node, file) } : create_issue(key, node))
      end

      def create_issue(key, node, file = nil)
        Inquisition::Issue.new(
          severity: :low,
          path: file&.path || node.data[:path],
          line: file&.line_num,
          message: "#{node.data[:type] ? 'missing translate' : 'unused'} key: #{key}, value: #{node.value}",
          runner: self
        )
      end
    end
  end
end
