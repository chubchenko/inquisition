module Inquisition
  module Auditors
    module Backend
      module RailsBestPractices
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
