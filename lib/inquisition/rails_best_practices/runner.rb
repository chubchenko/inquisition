require 'rails_best_practices'

module Inquisition
  module RailsBestPractices
    class Runner < ::Inquisition::Runner
      USER_CONFIG_PATH = 'config/rails_best_practices.yml'.freeze
      INQUISITION_CONFIG_PATH = 'config/rails_best_practices/config.yml'.freeze

      def call
        analyzer = ::RailsBestPractices::Analyzer.new(Rails.root, options)
        check_errors(analyzer)
        @issues
      end

      private

      def options
        { 'config' => config_path, 'silent' => true }
      end

      def config_path
        File.exist?(USER_CONFIG_PATH) ? USER_CONFIG_PATH : File.join(Inquisition.root, INQUISITION_CONFIG_PATH)
      end

      def check_errors(analyzer)
        analyzer.analyze
        create_issue(analyzer.errors) if analyzer.errors.any?
      end

      def create_issue(data_errors)
        data_errors.each do |error|
          @issues << Inquisition::Issue.new(Issue.new(error).to_h.merge(runner: self))
        end
      end
    end
  end
end
