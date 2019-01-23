module Inquisition
  module Auditors
    module Backend
      module Fasterer
        class Runner < Auditors::Runner
          private

          def command
            'fasterer'
          end
        end
      end
    end
  end
end
