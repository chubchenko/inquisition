module Inquisition
  module Auditors
    module Backend
      module Fasterer
        class Installer < Auditors::Installer
          class << self
            private

            def configurers
              [
                Core::Configurers::CopyFileConfigure.new(file: '.fasterer.yml')
              ]
            end
          end
        end
      end
    end
  end
end
