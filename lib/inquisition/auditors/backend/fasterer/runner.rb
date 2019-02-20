module Inquisition
  module Auditors
    module Backend
      module Fasterer
        class Runner < Core::Runners::SingleRunner
          private

          def command
            'fasterer'
          end
        end
      end
    end
  end
end
