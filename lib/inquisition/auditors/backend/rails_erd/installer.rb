module Inquisition
  module Auditors
    module Backend
      module RailsErd
        class Installer < Auditors::Installer
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
