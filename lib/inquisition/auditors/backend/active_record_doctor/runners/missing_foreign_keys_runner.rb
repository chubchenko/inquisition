module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        module Runners
          class MissingForeignKeysRunner < Core::Runners::SingleRunner
            private

            def command
              'rake active_record_doctor:missing_foreign_keys'
            end

            def formatter
              Formatters::MissingForeignKeysFormatter
            end
          end
        end
      end
    end
  end
end
