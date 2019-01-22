module Inquisition
  module Auditors
    module Backend
      module Reek
        class Installer < Auditors::Installer
          class << self
            private

            def configers
              [
                Core::Configers::CopyFileConfiger.new(file: '.reek.yml')
              ]
            end
          end
        end
      end
    end
  end
end
