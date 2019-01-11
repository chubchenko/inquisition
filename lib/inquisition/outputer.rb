module Inquisition
  class Outputer
    class << self
      def base_config_exist
        puts_message('messages.using_existing_config')
      end

      def setuping_inquisition
        puts_message('messages.inquisition_setuping')
      end

      def common_configs_setuped
        puts_message('messages.common_configs_setuped')
      end

      def front_configs_setuped
        puts_message('messages.front_configs_setuped')
      end

      def config_already_exist(linter_name)
        puts_message('messages.config_already_exist', linter_name: linter_name)
      end

      def done
        puts_message('messages.done', color: :green)
      end

      def creates_config_files
        puts_message('messages.creates_config_files')
      end

      def setups_all_conf_linters
        puts_message('messages.setups_all_conf_linters')
      end

      def additional_software_not_found(command)
        puts_message('errors.absence_additional_software', command: command)
      end

      private

      def puts_message(translate, color: :uncolorize, **args)
        puts I18n.t(translate, args).colorize(color)
      end
    end
  end
end
