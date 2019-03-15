module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        module MissingNonNullConstraint
          class Runner < Core::Runners::SingleRunner
            private

            def command
              'rake active_record_doctor:missing_non_null_constraint'
            end

            def formatter
              MissingNonNullConstraint::Formatter
            end
          end
        end
      end
    end
  end
end
