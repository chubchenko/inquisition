module Inquisition
  module Auditors
    module Backend
      module HamlLint
        class Installer < Core::Installers::SingleInstaller
          class << self
            private

            def checkers
              [
                Core::Checkers::GemChecker.new(name: 'haml')
              ]
            end
          end
        end
      end
    end
  end
end
