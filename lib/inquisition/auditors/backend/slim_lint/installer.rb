module Inquisition
  module Auditors
    module Backend
      module SlimLint
        class Installer < Core::Installers::SingleInstaller
          class << self
            private

            def checkers
              [
                Core::Checkers::GemChecker.new(name: 'slim')
              ]
            end
          end
        end
      end
    end
  end
end
