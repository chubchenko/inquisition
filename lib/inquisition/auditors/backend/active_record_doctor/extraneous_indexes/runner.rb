module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        module ExtraneousIndexes
          class Runner < Core::Runners::SingleRunner
            private

            def command
              'rake active_record_doctor:extraneous_indexes'
            end

            def formatter
              ExtraneousIndexes::Formatter
            end
          end
        end
      end
    end
  end
end
