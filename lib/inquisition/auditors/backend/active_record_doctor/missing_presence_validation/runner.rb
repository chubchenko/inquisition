module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        module MissingPresenceValidation
          class Runner < Core::Runners::SingleRunner
            private

            def command
              'rake active_record_doctor:missing_presence_validation'
            end

            def formatter
              MissingPresenceValidation::Formatter
            end
          end
        end
      end
    end
  end
end
