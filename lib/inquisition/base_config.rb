module Inquisition
  class BaseConfig
    CONFIG_FILE_NAME = 'inquisition.yml'.freeze
    TARGET_DIRECTORY = Dir.pwd

    class << self
      def initialize_config
        create_config unless config_exist?
      end

      def config_exist?
        Dir.glob(File.join(TARGET_DIRECTORY, CONFIG_FILE_NAME)).any?
      end

      def config_enabled?(*args)
        args.unshift(:inquisition).push(:Enabled)
        configs.dig(*args) == true
      end

      def auditors
        configs[:inquisition][:linters]
      end

      private

      def configs
        @configs ||= YAML.load_file(File.join(TARGET_DIRECTORY, CONFIG_FILE_NAME))
      end

      def create_config
        FileUtils.cp config_file_template, TARGET_DIRECTORY, preserve: true, verbose: false
      end

      def config_file_template
        File.join(File.dirname(__dir__), 'inquisition', 'utils', CONFIG_FILE_NAME)
      end
    end
  end
end
