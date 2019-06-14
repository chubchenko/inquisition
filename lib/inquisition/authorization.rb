module Inquisition
  module Authorization
    def authenticate_installer
      check_base_config_exists
    end

    def authenticate_runner
      check_base_config_exists
    end

    private

    def check_base_config_exists
      raise Errors::BaseConfigAbsenseError unless BaseConfig.instance.config_exist?
    end
  end
end
