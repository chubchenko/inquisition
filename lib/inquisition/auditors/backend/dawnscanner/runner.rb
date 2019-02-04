module Inquisition
  module Auditors
    module Backend
      module Dawnscanner
        class Runner < Core::Runners::SingleRunner
          private

          def command
            'dawn --json .'
          end
        end
      end
    end
  end
end
