module Inquisition
  module Auditors
    module Frontend
      module I18nTasks
        class Installer < Auditors::Installer
          class << self
            private

            def configers
              [
                Core::Configers::CopyFileConfiger.new(file: 'i18n-tasks.yml', destination: 'config')
              ]
            end
          end
        end
      end
    end
  end
end
