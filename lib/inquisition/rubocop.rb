require 'rubocop'

require_relative 'rubocop/rubocop_modified_runner'
require_relative 'rubocop/runner'
require_relative 'rubocop/vulnerability'

module Inquisition
  module Rubocop
    class << self
      def configuration
        ::RuboCop::ConfigStore.new.tap do |config_store|
          config_store.options_config = configuration_path
        end
      end

      private

      def configuration_path
        return ::RuboCop::ConfigLoader::DOTFILE if File.exist?(::RuboCop::ConfigLoader::DOTFILE)

        File.join(Inquisition.root, 'config', 'rubocop', 'config.yml')
      end
    end
  end
end
