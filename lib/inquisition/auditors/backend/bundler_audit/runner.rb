module Inquisition
  module Auditors
    module Backend
      module BundlerAudit
        class Runner < Auditors::Runner
          private

          def command
            'bundle audit'
          end
        end
      end
    end
  end
end
