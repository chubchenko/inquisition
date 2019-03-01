module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        module UnindexedForeignKeys
          class Runner < Core::Runners::SingleRunner
            private

            def command
              'rake active_record_doctor:unindexed_foreign_keys'
            end

            def formatter
              UnindexedForeignKeys::Formatter
            end
          end
        end
      end
    end
  end
end
