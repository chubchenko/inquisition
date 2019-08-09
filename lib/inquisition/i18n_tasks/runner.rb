require 'i18n/tasks/cli'

module Inquisition
  module I18nTasks
    class Runner < ::Inquisition::Runner
      def call
        base_task = ::I18n::Tasks::BaseTask.new
        errors = { missing_translate: base_task.missing_keys, unused: base_task.unused_keys }
        parse_data_errors(errors)
        @issues
      end

      private

      def parse_data_errors(errors)
        errors.each do |error_type, error|
          error.keys.each { |key, node| @issues << create_issue(error_type, key, node) }
        end
      end

      def create_issue(error_type, key, node)
        Inquisition::Issue.new(
          severity: :low,
          path: node.data[:path],
          line: nil,
          message: "#{error_type.to_s.tr('_', ' ')} key: #{key}, value: #{node.value}",
          runner: self
        )
      end
    end
  end
end
