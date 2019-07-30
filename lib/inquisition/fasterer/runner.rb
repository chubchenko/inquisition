require 'fasterer/file_traverser'

module Inquisition
  module Fasterer
    class Runner < ::Inquisition::Runner
      attr_reader :issues
      APP_PATH = '.'.freeze

      def call
        @issues = []
        fasterer = ::Fasterer::FileTraverser.new(APP_PATH)
        fasterer.scannable_files.each { |file| scan_file(file) }
        issues
      end

      private

      def scan_file(path)
        analyzer = ::Fasterer::Analyzer.new(path)
        analyzer.scan
        define_errors(analyzer) if analyzer.errors.any?
      end

      def define_errors(data)
        data.errors.each { |error| issues << create_issue(error, data.file_path) }
      end

      def create_issue(error, file_error)
        Inquisition::Issue.new(
          level: Inquisition::Issue::LEVELS[:low],
          line: error.line_number,
          runner: self,
          file: file_error,
          message: error.explanation
        )
      end
    end
  end
end
