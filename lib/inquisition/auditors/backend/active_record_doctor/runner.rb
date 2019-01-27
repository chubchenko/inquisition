module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        class Runner < Auditors::Runner
          private

          def command
            'rails_best_practices -f json .'
          end
        end
      end
    end
  end
end
