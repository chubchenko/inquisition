module Inquisition
  module Auditors
    module Backend
      module Undercover
        class Installer < Auditors::Installer
          class << self
            private

            def checkers
              [
                Core::Checkers::AdditionalSoftwareChecker.new(command: 'cmake --version')
              ]
            end
          end
        end
      end
    end
  end
end
