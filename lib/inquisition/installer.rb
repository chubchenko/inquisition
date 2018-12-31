module Inquisition
  class Installer
    class << self
      def call
        if BaseConfig.config_exist?
          output_existing_message
        else
          BaseConfig.initialize_config
          puts I18n.t('messages.inquisition_setuping')
        end
        output_complete_message
      end

      private

      def output_existing_message
        puts I18n.t('messages.using_existing_config')
      end

      def output_complete_message
        puts I18n.t('messages.done').green
      end
    end
  end
end
