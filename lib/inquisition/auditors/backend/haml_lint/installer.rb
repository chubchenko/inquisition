module Inquisition
  module Auditors
    module Backend
      module HamlLint
        class Installer < Auditors::Installer
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
