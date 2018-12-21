module Inquisition
  module Authentication
    def authenticate_installer
      check_base_config_exists
    end

    private

    def check_base_config_exists
      raise Errors::AuthenticationError unless Installer.config_exists?
    end
  end
end
