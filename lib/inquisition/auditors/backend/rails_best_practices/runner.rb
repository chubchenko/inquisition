module Inquisition
  module Auditors
    module Backend
      module RailsBestPractices
        class Runner < Core::Runners::SingleRunner
          private

          def command
            'rails_best_practices -f json .'
          end
        end
      end
    end
  end
end
