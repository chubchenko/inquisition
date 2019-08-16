require 'i18n/tasks'

module Inquisition
  module I18nTasks
    class Runner < ::Inquisition::Runner
      def call
        @base_task = ::I18n::Tasks::BaseTask.new
        parse_missing_keys
        parse_unused_keys
        @issues.flatten
      end

      private

      attr_reader :base_task

      def parse_missing_keys
        base_task.missing_keys.keys.each do |key, node|
          files = node.data[:occurrences]
          @issues << if files
                       files.map { |file| create_issue(key, node, file) }
                     else
                       create_issue(key, node)
                     end
        end
      end

      def parse_unused_keys
        base_task.unused_keys.keys.each { |key, node| @issues << create_issue(key, node) }
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
