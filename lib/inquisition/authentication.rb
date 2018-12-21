module Inquisition
  module Authentication
    def authenticate_installer
      check_base_config_exists
    end

    private

    def check_base_config_exists
      raise Errors::AuthenticationError unless Installer.config_exists?
      # begin
      #   raise Exeption unless Installer.config_exists?
      # rescue Errors::AuthenticationError.new
      #   # Errors::AuthenticationError.new(e)
      # end
    end
  end
end
