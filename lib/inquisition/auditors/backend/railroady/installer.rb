module Inquisition
  module Auditors
    module Backend
      module Railroady
        class Installer < Core::Installers::SingleInstaller
          class << self
            private

            def checkers
              [
                Core::Checkers::AdditionalSoftwareChecker.new(command: 'dot -V')
              ]
            end
          end
        end
      end
    end
  end
end
