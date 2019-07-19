require 'fasterer/file_traverser'

module Inquisition
  module Fasterer
    class Runner < ::Inquisition::Runner
      attr_reader :errors

      def call
        @errors = []
        fasterer = ::Fasterer::FileTraverser.new('.')
        fasterer.scannable_files.each { |file| scan_file(file) }
        errors
      end

      private

      def scan_file(path)
        analyzer = ::Fasterer::Analyzer.new(path)
        analyzer.scan
        errors << create_issue(analyzer) if analyzer.errors.any?
      end

      def create_issue(data)
        current_error = data.errors.instance_variable_get(:@offenses).first
        Inquisition::Issue.new(
          level: Inquisition::Issue::LEVEL_LOW,
          line: current_error.line_number,
          runner: self,
          file: data.file_path,
          message: current_error.explanation
        )
      end
    end
  end
end
