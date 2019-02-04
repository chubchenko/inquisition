module Inquisition
  module Core
    module Installers
      class SingleInstaller < BaseInstaller
        class << self
          def call
            run_checkers
            run_configurers
          end

          private

          def run_checkers
            checkers.each(&:call)
          end

          def run_configurers
            configurers.each(&:call)
          end

          def checkers
            []
          end

          def configurers
            []
          end
        end
      end
    end
  end
end
