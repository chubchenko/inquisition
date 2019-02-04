module Inquisition
  module Auditors
    module Backend
      module Rubocop
        class Runner < Core::Runners::SingleRunner
          private

          def command
            'rubocop --format json'
          end
        end
      end
    end
  end
end
