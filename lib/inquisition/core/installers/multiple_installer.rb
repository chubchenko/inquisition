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
            installers.each do |installer, path|
              installer.call if BaseConfig.config_enabled?(*path)
            end
          end

          def installers
            {}
          end

          def config_path(*keys)
            [:linters, *path, *keys]
          end

          def path
            []
          end
        end
      end
    end
  end
end
