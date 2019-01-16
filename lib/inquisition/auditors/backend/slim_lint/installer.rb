module Inquisition
  module Auditors
    module Backend
      module SlimLint
        class Installer < Auditors::Installer
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
