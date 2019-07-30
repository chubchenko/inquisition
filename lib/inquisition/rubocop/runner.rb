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

      # ::RuboCop::ConfigLoader::DOTFILE = 'config/.rubocop.yml'.freeze

      def call
        # if config in the app?
        #   load config provided by app
        # else
        #   load default config

        #   + rubocop-rails
        #   + rubocop-performance
        #   + rubocop-rspec
        # end

        offenses = RuboCopModifiedRunner.new(default_config_path, ::RuboCop::ConfigStore.new).run(['.'])
        offenses.each { |offense| create_issue(offense) }
        issues
      end

      private

      def default_config_path
        # {}
        {:config=>"config/.rubocop.yml"}
      end

      def create_issue(offense)
        offense_body = offense.last.first
        @issues << Inquisition::Issue.new(level: LEVELS[offense_body.severity.name],
                                          file: offense.first, message: offense_body.message,
                                          runner: self, line: offense_body.line)
      end
    end
  end
end
