module Inquisition
  module Auditors
    module Backend
      module RailsErd
        class Installer < Core::Installers::SingleInstaller
          class << self
            private

            def checkers
              [
                Core::Checkers::GemChecker.new(name: 'rails-erd')
              ]
            end
          end
        end
      end
    end
  end
end
