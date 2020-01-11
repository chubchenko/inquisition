require 'fasterer/file_traverser'
require 'inquisition/fasterer/file_traverser'

module Inquisition
  module Fasterer
    class Runner < ::Inquisition::Runner
      def call
        @fasterer = FileTraverser.new(Rails.root)
        @fasterer.scannable_files.each { |file| scan_file(file) }
        @issues
      end

      private

      def scan_file(path)
        analyzer = ::Fasterer::Analyzer.new(path)
        analyzer.scan
        check_analyser_config_rules(analyzer)
      end

      def check_analyser_config_rules(analyzer)
        return unless @fasterer.offenses_grouped_by_type(analyzer).any?

        define_errors(analyzer) if analyzer.errors.any?
      end

      def define_errors(data)
        data.errors.each do |error|
          @issues << create_issue(error, Pathname(data.file_path).relative_path_from(Rails.root).to_s)
        end
      end

      def create_issue(error, file_error)
        Inquisition::Issue.new(
          severity: Severity::LOW,
          line: error.line_number,
          runner: self,
          path: file_error,
          message: error.explanation,
          context: error.offense_name
        )
      end
    end
  end
end
