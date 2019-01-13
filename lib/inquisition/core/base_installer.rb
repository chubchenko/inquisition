module Inquisition
  module Core
    class BaseInstaller
      class << self
        def call
          run_installers
        end

        private

        def run_installers
          installers.each do |installer, path|
            installer.call if BaseConfig.config_enabled?(*path)
          end
        end

        def installers
          {
            Auditors::Backend::Installer => config_path(:backend),
            Auditors::Frontend::Installer => config_path(:frontend),
            Auditors::Common::Installer => config_path(:common)
          }
        end

        def config_path(*path)
          [:linters, *path]
        end
      end
    end
  end
end
