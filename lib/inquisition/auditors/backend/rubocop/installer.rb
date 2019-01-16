module Inquisition
  module Auditors
    module Backend
      module Rubocop
        class Installer < Auditors::Installer
          class << self
            private

            def configers
              [
                Core::Configers::CopyFileConfiger.new(file: '.rubocop.yml')
              ]
            end
          end
        end
      end
    end
  end
end
