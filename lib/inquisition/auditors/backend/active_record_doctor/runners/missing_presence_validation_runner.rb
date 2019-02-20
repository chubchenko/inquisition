module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        module Runners
          class MissingPresenceValidationRunner < Core::Runners::SingleRunner
            private

            def command
              'rake active_record_doctor:missing_presence_validation'
            end

            def formatter
              Formatters::MissingPresenceValidationFormatter
            end
          end
        end
      end
    end
  end
end
