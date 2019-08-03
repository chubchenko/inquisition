require 'rails_best_practices'

module Inquisition
  module RailsBestPractices
    class Runner < ::Inquisition::Runner
      NAME_CONFIG = 'rails_best_practices.yml'.freeze

      def call
        analyzer = ::RailsBestPractices::Analyzer.new(APP_PATH, 'config' => NAME_CONFIG, 'silent' => true)
        check_errors(analyzer)
        issues
      end

      def check_errors(analyzer)
        analyzer.analyze
        define_errors(analyzer.errors) if analyzer.errors.any?
      end

      def define_errors(data_errors)
        data_errors.each { |error| @issues << create_issue(error) }
      end

      def create_issue(error)
        Inquisition::Issue.new(
          severity: :low,
          line: error.line_number,
          runner: self,
          path: error.filename,
          message: error.message
        )
      end
    end
  end
end
