module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        module Runners
          class MissingNonNullConstraintRunner < Auditors::Runner
            private

            def command
              'rake active_record_doctor:missing_non_null_constraint'
            end

            def formatter
              Formatters::MissingNonNullConstraintFormatter
            end
          end
        end
      end
    end
  end
end
