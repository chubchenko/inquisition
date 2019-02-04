module Inquisition
  module Auditors
    module Backend
      module BundlerAudit
        class Runner < Core::Runners::SingleRunner
          private

          def command
            'bundle audit'
          end
        end
      end
    end
  end
end
