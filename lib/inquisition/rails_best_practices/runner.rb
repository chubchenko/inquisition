require 'rails_best_practices'

module Inquisition
  module RailsBestPractices
    class Runner < ::Inquisition::Runner
      def call
        analyzer.errors.map do |error|
          issue_for(error)
        end
      end

      private

      def analyzer
        @analyzer ||= begin
          analyzer = ::RailsBestPractices::Analyzer.new(Rails.root, 'silent' => true)
          analyzer.analyze
          analyzer
        end
      end

      def issue_for(error)
        Issue.new(
          Warning.new(error).to_h.merge(runner: self)
        )
      end
    end
  end
end
