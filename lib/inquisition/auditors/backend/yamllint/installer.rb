module Inquisition
  module Auditors
    module Backend
      module Yamllint
        class Installer < Core::Installers::SingleInstaller
          class << self
            private

            def checkers
              [
                Core::Checkers::AdditionalSoftwareChecker.new(command: 'yamllint -v')
              ]
            end
          end
        end
      end
    end
  end
end
