module Inquisition
  module Auditors
    module Backend
      module Rubocop
        class Runner < Auditors::Runner
          private

          def command
            'rubocop --format json'
          end
        end
      end
    end
  end
end
