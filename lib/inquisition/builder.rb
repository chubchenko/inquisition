module Inquisition
  class Builder
    class << self
      def call
        base_config = BaseConfig.instance
        if base_config.config_exist?
          MessageNotifier.base_config_exist
        else
          base_config.initialize_config
          MessageNotifier.setuping_inquisition
        end
        MessageNotifier.done
      end
    end
  end
end
