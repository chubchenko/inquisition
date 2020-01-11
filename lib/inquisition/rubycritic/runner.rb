require 'rubycritic/analysers_runner'

require_relative 'analysers/reek'
require_relative 'analysers/flay'
require_relative 'analysers/flog'
require_relative 'analysers/complexity'

module Inquisition
  module Rubycritic
    class Runner < ::Inquisition::Runner
      ANALYSERS = [
        Analysers::Flay,
        Analysers::Flog,
        Analysers::Reek,
        Analysers::Complexity
      ].freeze

      attr_reader :common_score

      def call
        issues = []

        analysed_modules.map(&:smells).flatten.each do |smell|
          issues << smell.locations.map do |location|
            issue_for(smell, location)
          end
        end

        issues.flatten
      end

      private

      attr_reader :issues

      def analysed_modules
        @analysed_modules ||= begin
          analysed_modules = ::RubyCritic::AnalysedModulesCollection.new([Rails.root])

          ANALYSERS.each do |analyser_class|
            analyser_instance = analyser_class.new(analysed_modules)
            analyser_instance.run
          end

          @common_score = analysed_modules&.score

          analysed_modules
        end
      end

      def issue_for(smell, location)
        Issue.new(
          Smell.new(smell, location).to_h.merge(runner: self)
        )
      end
    end
  end
end
