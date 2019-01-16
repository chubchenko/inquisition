module Inquisition
  module Auditors
    module Backend
      module Fasterer
        class Installer < Auditors::Installer
          class << self
            private

            def configers
              [
                Core::Configers::CopyFileConfiger.new(file: '.fasterer.yml')
              ]
            end
          end
        end
      end
    end
  end
end
