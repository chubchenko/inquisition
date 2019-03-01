module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        module MissingUniqueIndexes
          class Runner < Core::Runners::SingleRunner
            private

            def command
              'rake active_record_doctor:missing_unique_indexes'
            end

            def formatter
              MissingUniqueIndexes::Formatter
            end
          end
        end
      end
    end
  end
end
