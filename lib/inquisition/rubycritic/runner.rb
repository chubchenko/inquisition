require 'rubycritic/analysers_runner'
require 'inquisition/rubycritic/analysers/reek'
require 'inquisition/rubycritic/analysers/flay'
require 'inquisition/rubycritic/analysers/flog'

module Inquisition
  module Rubycritic
    class Runner < ::Inquisition::Runner
      ANALYSERS = {
        Analysers::Flay => :duplication,
        Analysers::Flog => :complexity,
        Analysers::Reek => :complexity
      }.freeze

      def call
        run_analyzers
        @issues
      end

      private

      def run_analyzers
        ANALYSERS.each do |analyser_class, issue_category|
          result = analyser_class.new(::RubyCritic::AnalysedModulesCollection.new([Rails.root])).run
          smells = result.map(&:smells).flatten
          compose_issues(smells, issue_category)
        end
      end

      def compose_issues(smells, issue_category)
        smells.each do |smell|
          smell.locations.each { |location| @issues << create_issue(smell, location, issue_category) }
        end
      end

      def create_issue(error, location_error, issue_category)
        Inquisition::Issue.new(
          severity: :low,
          category: issue_category,
          path: location_error.pathname.relative_path_from(Rails.root).to_s,
          line: location_error.line,
          runner: self,
          message: error.message
        )
      end
    end
  end
end
