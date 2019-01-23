module Inquisition
  module Auditors
    module Backend
      module Reek
        class Runner < Auditors::Runner
          private

          def command
            'reek . --format json'
          end
        end
      end
    end
  end
end
