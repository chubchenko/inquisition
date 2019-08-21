require 'i18n/tasks'

module Inquisition
  module I18nTasks
    class Runner < ::Inquisition::Runner
      INQUISITION_CONFIG_PATH = 'config/i18n_tasks/config.yml'.freeze
      USER_CONFIG_PATH = 'config/i18n-tasks.yml'.freeze

      def call
        @base_task = ::I18n::Tasks::BaseTask.new
        @base_task.config = load_config_file unless File.exist?(File.join(Rails.root, USER_CONFIG_PATH))
        parse_missing_keys
        parse_unused_keys
        @issues.flatten
      end

      private

      attr_reader :base_task

      def load_config_file
        YAML.load_file(File.join(Inquisition.root, INQUISITION_CONFIG_PATH))
      end

      def parse_missing_keys
        base_task.missing_keys.keys.each do |key, node|
          files = node.data[:occurrences]
          @issues << if files
                       files.map { |file| create_issue(key, node, file, :missing) }
                     else
                       create_issue(key, node, nil, :missing)
                     end
        end
      end

      def parse_unused_keys
        base_task.unused_keys.keys.each { |key, node| @issues << create_issue(key, node, nil, :unused) }
      end

      def create_issue(key, node, file = nil, type = :missing)
        Inquisition::Issue.new(
          severity: :low,
          path: create_relative_path(file&.path || node.data[:path]),
          line: file&.line_num,
          message: type == :missing ? "missing key: #{key}" : "unused key: #{key}, value: #{node.value}",
          runner: self
        )
      end

      def create_relative_path(path)
        return path if Rails.env.development?

        Pathname(path).relative_path_from(Rails.root).to_s
      end
    end
  end
end
