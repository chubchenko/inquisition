module Inquisition
  module Auditors
    module Frontend
      module I18nTasks
        class Installer < Core::Installers::SingleInstaller
          class << self
            private

            def configurers
              [
                Core::Configurers::CopyFileConfigure.new(file: 'i18n-tasks.yml', destination: 'config')
              ]
            end
          end
        end
      end
    end
  end
end
