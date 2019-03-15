module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        module UnindexedDeletedAt
          class Runner < Core::Runners::SingleRunner
            private

            def command
              'rake active_record_doctor:unindexed_deleted_at'
            end

            def formatter
              UnindexedDeletedAt::Formatter
            end
          end
        end
      end
    end
  end
end
