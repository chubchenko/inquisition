module Inquisition
  module Auditors
    module Backend
      module Dawnscanner
        class Runner < Auditors::Runner
          private

          def command
            'dawn --json .'
          end
        end
      end
    end
  end
end
