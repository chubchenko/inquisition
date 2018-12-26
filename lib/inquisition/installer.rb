module Inquisition
  class Installer
    class << self
      CONFIG_FILE_NAME = 'inquisition.yml'.freeze
      TARGET_DIRECTORY = Dir.pwd

      def call
        config_exists? ? output_existing_message : create_config
        output_complete_message
      end

      def config_exists?
        Dir.glob(CONFIG_FILE_NAME).any?
      end

      private

      def output_existing_message
        puts I18n.t('messages.using_existing_config')
      end

      def output_complete_message
        puts I18n.t('messages.done').green
      end

      def create_config
        puts I18n.t('messages.inquisition_setuping')
        FileUtils.cp config_file, TARGET_DIRECTORY, preserve: true, verbose: false
      end

      def config_file
        File.join(File.dirname(__dir__), 'inquisition', 'utils', CONFIG_FILE_NAME)
      end
    end
  end
end
