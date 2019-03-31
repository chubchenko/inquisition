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
          Auditors::Backend::Installer => :backend,
          Auditors::Frontend::Installer => :frontend,
          Auditors::Common::Installer => :common
        }
      end
    end
  end
end
