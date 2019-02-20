module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        module Runners
          class UnindexedForeignKeysRunner < Core::Runners::SingleRunner
            private

            def command
              'rake active_record_doctor:unindexed_foreign_keys'
            end

            def formatter
              Formatters::UnindexedForeignKeysFormatter
            end
          end
        end
      end
    end
  end
end
