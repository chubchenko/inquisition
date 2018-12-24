module Inquisition
  module Authorization
    def authenticate_installer
      check_base_config_exists
    end

    private

    def check_base_config_exists
      raise Errors::BaseConfigAbsenseError unless Installer.config_exists?
    end
  end
end
