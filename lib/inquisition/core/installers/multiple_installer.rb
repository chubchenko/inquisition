module Inquisition
  module Core
    module Installers
      class MultipleInstaller < BaseInstaller
        class << self
          def call
            run_installers
          end

          private

          def run_installers
            installers.each do |installer, auditor|
              installer.call if BaseConfig.instance.auditor_enabled?(auditor)
            end
          end

          def installers
            {}
          end
        end
      end
    end
  end
end
