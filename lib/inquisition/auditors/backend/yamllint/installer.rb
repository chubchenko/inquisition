module Inquisition
  module Auditors
    module Backend
      module Yamllint
        class Installer < Auditors::Installer
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
