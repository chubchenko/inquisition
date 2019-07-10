module Inquisition
  class MessageNotifier
    class << self
      def base_config_exist
        output('Using existing config for inquisition...')
      end

      def setuping_inquisition
        output('Inquisition setuping...')
      end

      def common_configs_setuped
        output('Common configs setuped')
      end

      def front_configs_setuped
        output('Front configs setuped')
      end

      def config_already_exist(linter_name)
        output("Config for #{linter_name} already exists")
      end

      def done
        output('...Done!', color: :green)
      end

      def creates_config_files
        output('Creates configuration file')
      end

      def setups_all_conf_linters
        output('Setups all configs for linters')
      end

      def additional_software_not_found(command)
        output("Additional software with command #{command} not found")
      end

      private

      def output(message, color: :uncolorize)
        puts message.colorize(color)
      end
    end
  end
end
