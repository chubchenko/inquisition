module Inquisition
  module Auditors
    module Backend
      module RubyLint
        class Installer < Core::Installers::SingleInstaller
          class << self
            private

            def checkers
              [
                Core::Checkers::RubyVersionChecker.new(from_version: '1.9.0')
              ]
            end
          end
        end
      end
    end
  end
end
