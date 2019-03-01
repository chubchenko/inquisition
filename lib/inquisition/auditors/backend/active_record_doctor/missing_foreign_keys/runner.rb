module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        module MissingForeignKeys
          class Runner < Core::Runners::SingleRunner
            private

            def command
              'rake active_record_doctor:missing_foreign_keys'
            end

            def formatter
              MissingForeignKeys::Formatter
            end
          end
        end
      end
    end
  end
end
