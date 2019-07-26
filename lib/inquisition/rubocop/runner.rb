require 'rubocop'

module Inquisition
  module RuboCop
    class Runner < ::Inquisition::Runner
      LEVELS = {
        refactor: Inquisition::Issue::LEVELS[:low],
        convention: Inquisition::Issue::LEVELS[:low],
        warning: Inquisition::Issue::LEVELS[:medium],
        error: Inquisition::Issue::LEVELS[:high],
        fatal: Inquisition::Issue::LEVELS[:high]
      }.freeze

      ::RuboCop::ConfigLoader::DOTFILE = 'config/.rubocop.yml'.freeze

      def call
        offenses = Inquisition::RuboCop::RuboCopModifiedRunner.new({}, ::RuboCop::ConfigStore.new).run(['.'])
        offenses.each { |offense| create_issue(offense) }
        issues
      end

      private

      def create_issue(offense)
        offense_body = offense.last.first
        @issues << Inquisition::Issue.new(level: LEVELS[offense_body.severity.name],
                                          file: offense.first, message: offense_body.message,
                                          runner: self, line: offense_body.line)
      end
    end
  end
end
