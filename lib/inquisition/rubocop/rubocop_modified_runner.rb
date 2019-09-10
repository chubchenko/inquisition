module Inquisition
  module Rubocop
    class RubocopModifiedRunner < ::RuboCop::Runner
      attr_reader :issues

      def initialize(options, config_store)
        super
        @issues = []
      end

      def run(paths)
        target_files = find_target_files(paths)
        inspect_files(target_files)
      end

      def process_file(file)
        file_started(file)
        offenses = file_offenses(file)
        @issues << { ::RuboCop::PathUtil.relative_path(file, Rails.root.to_s) => offenses } if offenses.any?
        offenses
      end

      def inspect_files(files)
        inspected_files = []
        each_inspected_file(files) { |file| inspected_files << file }
        issues
      end
    end
  end
end
