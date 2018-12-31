module Inquisition
  class Configer
    extend Inquisition::Authorization

    class << self
      def call
        authenticate_installer
        run_configers
      end

      private

      def run_configers
        Auditors::Backend::Configer.call if BaseConfig.config_enabled?('linters', 'backend')
        Auditors::Frontend::Configer.call if BaseConfig.config_enabled?('linters', 'frontend')
        Auditors::Common::Configer.call if BaseConfig.config_enabled?('linters', 'common')
      end
    end
  end
end
