module Inquisition
  class Build
    class << self
      def call
        if BaseConfig.config_exist?
          Outputer.base_config_exist
        else
          BaseConfig.initialize_config
          Outputer.setuping_inquisition
        end
        Outputer.done
      end
    end
  end
end
