module Inquisition
  module Auditors
    module Frontend
      class Installer < Core::Installers::MultipleInstaller
        class << self
          private

          def installers
            {
              I18nTasks::Installer => config_path(:i18n_tasks)
            }
          end

          def path
            [:frontend]
          end
        end
      end
    end
  end
end
