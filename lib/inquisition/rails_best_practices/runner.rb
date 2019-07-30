require 'rails_best_practices'

module Inquisition
  module RailsBestPractices
    class Runner < ::Inquisition::Runner
      def call
        analyzer = ::RailsBestPractices::Analyzer.new(APP_PATH, 'config' => 'rails_best_practices.yml')
        check_errors(analyzer)
        issues
      end

      def check_errors(analyzer)
        analyzer.analyze
        define_errors(analyzer.errors) if analyzer.errors.any?
      end

      def define_errors(data_errors)
        data_errors.each { |error| issues << create_issue(error) }
      end

      def create_issue(error)
        Inquisition::Issue.new(
          level: Inquisition::Issue::LEVELS[:low],
          line: error.line_number,
          runner: self,
          file: error.filename,
          message: error.message
        )
      end
    end
  end
end
