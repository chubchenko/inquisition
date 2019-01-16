module Inquisition
  module Auditors
    module Backend
      module LolDba
        class Installer < Auditors::Installer
          class << self
            private

            def checkers
              [
                Core::Checkers::GemChecker.new(name: 'i18n')
              ]
            end

            def configers
              [
                Core::Configers::CopyFileConfiger.new(file: 'i18n-tasks.yml', destination: 'config')
              ]
            end
          end
        end
      end
    end
  end
end
