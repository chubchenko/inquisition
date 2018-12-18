module Inquisition
  class Installer
    CONFIG_FILE_NAME = 'inquisition.yml'.freeze
    TARGET_DIRECTORY = Dir.pwd

    class << self
      def call
        config_exists? ? output_existing_message : create_config
        output_complete_message
      end

      private

      def output_existing_message
        puts 'Using existing config for inquisition...'
      end

      def output_complete_message
        puts '...Done!'.green
      end

      def config_exists?
        Dir.glob(CONFIG_FILE_NAME).any?
      end

      def create_config
        puts 'Inquisition setuping... '
        FileUtils.cp config_file, TARGET_DIRECTORY, preserve: true, verbose: false
      end

      def config_file
        File.join(File.dirname(__dir__), 'inquisition', 'utils', CONFIG_FILE_NAME)
      end
    end
  end
end
