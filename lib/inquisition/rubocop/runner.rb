require 'rubocop'

module Inquisition
  module RuboCop
    class Runner < ::Inquisition::Runner
      LEVELS = {
        refactor: :low,
        convention: :low,
        warning: :medium,
        error: :high,
        fatal: :high
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
        @issues << Inquisition::Issue.new(severity: LEVELS[offense_body.severity.name],
                                          path: offense.first, message: offense_body.message,
                                          runner: self, line: offense_body.line)
      end
    end
  end
end
