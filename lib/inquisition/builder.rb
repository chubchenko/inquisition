module Inquisition
  class Builder
    class << self
      def call
        if BaseConfig.config_exist?
          MessageNotifier.base_config_exist
        else
          BaseConfig.initialize_config
          MessageNotifier.setuping_inquisition
        end
        MessageNotifier.done
      end
    end
  end
end
