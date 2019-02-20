module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        module Runners
          class MissingPresenceValidationRunner < Auditors::Runner
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
