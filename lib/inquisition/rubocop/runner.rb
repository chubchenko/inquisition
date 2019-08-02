require 'rubocop'

module Inquisition
  module Rubocop
    class Runner < ::Inquisition::Runner
      LEVELS = {
        refactor: :low,
        convention: :low,
        warning: :medium,
        error: :high,
        fatal: :high
      }.freeze

      USERS_CONFIG_FILE = '.rubocop.yml'.freeze

      def call
        offenses = RuboCopModifiedRunner.new(options, config_store).run(['.'])
        offenses.each { |offense| create_issue(offense) }
        @issues
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
          @issues << Inquisition::Issue.new(severity: LEVELS[offense.severity.name],
                                            path: offenses.keys[0], message: offense.message,
                                            runner: self, line: offense.line)
        end
      end
    end
  end
end
