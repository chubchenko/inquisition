module Inquisition
  module Auditors
    module Backend
      module Fasterer
        class Runner < Core::SingleRunner
          private

          def command
            'fasterer'
          end
        end
      end
    end
  end
end
