module Inquisition
  module Rubocop
    class RubocopModifiedRunner < ::RuboCop::Runner
      class Offense < ::RuboCop::Cop::Team
        def offenses(processed_source)
          autocorrect_cops, other_cops = cops.partition(&:autocorrect?)
          can_correct = investigate(autocorrect_cops, processed_source)
          unsupported = investigate(other_cops, processed_source)

          can_correct.offenses.concat(unsupported.offenses)
        end
      end

      attr_reader :issues, :target_files

      def initialize(options, config_store)
        super
        @issues = []
      end

      def run(paths)
        @target_files = find_target_files(paths)
        inspect_files(target_files)
      end

      def process_file(file)
        file_started(file)

        offenses = file_offenses(file)
        # offenses = file_offense_with_autocorrect(file)

        @issues << { ::RuboCop::PathUtil.relative_path(file, Rails.root.to_s) => offenses } if offenses.any?
        offenses
      end

      def file_offense_with_autocorrect(file)
        processed_source = get_processed_source(file)
        config = @config_store.for(processed_source.path)
        team = Offense.new(mobilized_cop_classes(config), config, { auto_correct: true })
        offenses = team.offenses(processed_source)
      end

      def inspect_files(files)
        inspected_files = []
        each_inspected_file(files) { |file| inspected_files << file }
        issues
      end
    end
  end
end
