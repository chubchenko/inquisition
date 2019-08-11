require 'yaml'

module Inquisition
  module Fasterer
    class Config < ::Fasterer::Config
      def nil_file
        { SPEEDUPS_KEY => load_config['speedups'], EXCLUDE_PATHS_KEY => load_config['exclude_paths'] }
      end

      def load_config
        YAML.load_file(File.join(__dir__, '../../../config/fasterer/.fasterer.yml'))
      end
    end
  end
end
