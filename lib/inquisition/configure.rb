module Inquisition
  class Configure < Core::Installers::MultipleInstaller
    extend Inquisition::Authorization

    class << self
      def call
        authenticate_installer
        super
      end

      private

      def installers
        {
          Auditors::Backend::Installer => config_path(:backend),
          Auditors::Frontend::Installer => config_path(:frontend),
          Auditors::Common::Installer => config_path(:common)
        }
      end
    end
  end
end
