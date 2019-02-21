module Inquisition
  module Auditors
    module Backend
      module Rubocop
        class Installer < Core::Installers::SingleInstaller
          class << self
            private

            def configurers
              [
                Core::Configurers::CopyFileConfigure.new(file: '.rubocop.yml')
              ]
            end
          end
        end
      end
    end
  end
end
