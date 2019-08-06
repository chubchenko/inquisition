module Inquisition
  module Rubocop
    class Configuration
      class << self
        def call
          ::RuboCop::ConfigStore.new.tap do |config_store|
            config_store.options_config = configuration_file_path
          end
        end

        private

        def configuration_file_path
          return ::RuboCop::ConfigLoader::DOTFILE if File.exist?(::RuboCop::ConfigLoader::DOTFILE)

          File.join(Inquisition.root, 'config', 'rubocop', 'config.yml')
        end
      end
    end
  end
end
