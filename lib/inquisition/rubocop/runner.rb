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

      USERS_CONFIG_FILE = '.rubocop.yml'.freeze

      def call
        offenses = RuboCopModifiedRunner.new(options, config_store).run(['.'])
        offenses.each { |offense| create_issue(offense) }
        issues
      end

      private

      def options
        { config: choose_config }
      end

      def config_store
        config_store = ::RuboCop::ConfigStore.new
        config_store.options_config = options[:config]
        config_store
      end

      def choose_config
        return USERS_CONFIG_FILE if File.exist?(USERS_CONFIG_FILE)

        gem_root = File.realpath(File.join(File.dirname(__FILE__), '..', '..'))
        File.join(gem_root, 'config', '.rubocop.yml')
      end

      def create_issue(offenses)
        offenses.values.flatten.each do |offense|
          @issues << Inquisition::Issue.new(level: LEVELS[offense.severity.name],
                                            file: offenses.keys[0], message: offense.message,
                                            runner: self, line: offense.line)
        end
      end
    end
  end
end
