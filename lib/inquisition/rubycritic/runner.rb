require 'rubycritic/analysers_runner'
require 'inquisition/rubycritic/analysers/reek'
require 'inquisition/rubycritic/analysers/flay'
require 'inquisition/rubycritic/analysers/flog'

module Inquisition
  module Rubycritic
    class Runner < ::Inquisition::Runner
      ANALYSERS = [
        Analysers::Flay,
        Analysers::Flog,
        Analysers::Reek
      ].freeze

      def call
        run_analyzers
        @issues
      end

      private

      def run_analyzers
        ANALYSERS.each do |analyser_class|
          result = analyser_class.new(analysed_modules).run
          smells = result.map(&:smells).flatten
          compose_issues(smells)
        end
      end

      def compose_issues(smells)
        smells.each do |smell|
          smell.locations.each { |location| @issues << create_issue(smell, location) }
        end
      end

      def create_issue(error, location_error)
        Inquisition::Issue.new(
          severity: :low,
          path: location_error.pathname.relative_path_from(Rails.root).to_s,
          line: location_error.line,
          runner: self,
          message: error.message
        )
      end

      def analysed_modules
        ::RubyCritic::AnalysedModulesCollection.new([Rails.root])
      end
    end
  end
end
