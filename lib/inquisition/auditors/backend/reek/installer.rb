module Inquisition
  module Auditors
    module Backend
      module Reek
        class Installer < Core::Installers::SingleInstaller
          class << self
            private

            def configurers
              [
                Core::Configurers::CopyFileConfigure.new(file: '.reek.yml')
              ]
            end
          end
        end
      end
    end
  end
end
