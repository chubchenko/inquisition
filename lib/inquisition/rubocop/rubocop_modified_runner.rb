require_relative 'offense'

module Inquisition
  module Rubocop
    class RubocopModifiedRunner < ::RuboCop::Runner
      attr_reader :issues, :target_files

      def initialize(options, config_store)
        super
        @options = { auto_correct: true }
        @issues = []
      end

      def run(paths)
        @target_files = find_target_files(paths)
        inspect_files(target_files)
      end

      def process_file(file)
        file_started(file)
        offenses = file_offense_with_autocorrect(file)
        @issues << { ::RuboCop::PathUtil.relative_path(file, Rails.root.to_s) => offenses } if offenses.any?
        offenses
      end

      def file_offense_with_autocorrect(file)
        processed_source = get_processed_source(file)
        config = @config_store.for(processed_source.path)
        offenses = Offense.new(mobilized_cop_classes(config), config, @options).inspect_file(processed_source)
        add_redundant_disables(file, offenses.compact.sort, processed_source)
      end

      def inspect_files(files)
        inspected_files = []
        each_inspected_file(files) { |file| inspected_files << file }
        issues
      end
    end
  end
end
