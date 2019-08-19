require 'yaml'

module Inquisition
  module Fasterer
    class Config < ::Fasterer::Config
      def nil_file
        {
          SPEEDUPS_KEY => config['speedups'],
          EXCLUDE_PATHS_KEY => config['exclude_paths']
        }
      end

      def config
        @config ||= begin
          YAML.load_file(
            File.join(Inquisition.root, 'config', 'fasterer', 'config.yml')
          )
        end
      end
    end
  end
end
