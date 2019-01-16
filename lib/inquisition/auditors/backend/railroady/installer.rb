module Inquisition
  module Auditors
    module Backend
      module Railroady
        class Installer < Auditors::Installer
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
