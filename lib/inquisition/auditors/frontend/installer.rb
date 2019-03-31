module Inquisition
  module Auditors
    module Frontend
      class Installer < Core::Installers::MultipleInstaller
        class << self
          private

          def installers
            {
              I18nTasks::Installer => :i18n_tasks
            }
          end
        end
      end
    end
  end
end
