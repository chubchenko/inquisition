module Inquisition
  module Auditors
    module Backend
      module Reek
        class Runner < Core::Runners::SingleRunner
          private

          def command
            'reek . --format json'
          end
        end
      end
    end
  end
end
