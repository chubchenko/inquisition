module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        module Runners
          class ExtraneousIndexesRunner < Auditors::Runner
            private

            def command
              'rake active_record_doctor:extraneous_indexes'
            end

            def formatter
              Formatters::ExtraneousIndexesFormatter
            end
          end
        end
      end
    end
  end
end
