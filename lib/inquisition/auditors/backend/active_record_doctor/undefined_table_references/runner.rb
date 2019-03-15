module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        module UndefinedTableReferences
          class Runner < Core::Runners::SingleRunner
            private

            def command
              'rake active_record_doctor:undefined_table_references'
            end

            def formatter
              UndefinedTableReferences::Formatter
            end
          end
        end
      end
    end
  end
end
