require 'fasterer/file_traverser'

module Inquisition
  module Fasterer
    class Runner < ::Inquisition::Runner
      def call
        fasterer = ::Fasterer::FileTraverser.new(Rails.root)
        fasterer.scannable_files.each { |file| scan_file(file) }
        @issues
      end

      private

      def scan_file(path)
        analyzer = ::Fasterer::Analyzer.new(path)
        analyzer.scan
        define_errors(analyzer) if analyzer.errors.any?
      end

      def define_errors(data)
        data.errors.each { |error| @issues << create_issue(error, data.file_path) }
      end

      def create_issue(error, file_error)
        Inquisition::Issue.new(
          severity: :low,
          line: error.line_number,
          runner: self,
          path: file_error,
          message: error.explanation
        )
      end
    end
  end
end
