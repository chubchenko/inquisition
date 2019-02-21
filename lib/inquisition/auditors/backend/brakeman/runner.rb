module Inquisition
  module Auditors
    module Backend
      module Brakeman
        class Runner < Core::Runners::SingleRunner
          private

          def command
            'brakeman -f json'
          end
        end
      end
    end
  end
end
