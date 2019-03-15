module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        class Runner < Core::Runners::MultipleRunner
          private

          def runners
            {
              ExtraneousIndexes::Runner => config_path,
              MissingForeignKeys::Runner => config_path,
              MissingNonNullConstraint::Runner => config_path,
              MissingPresenceValidation::Runner => config_path,
              MissingUniqueIndexes::Runner => config_path,
              UndefinedTableReferences::Runner => config_path,
              UnindexedDeletedAt::Runner => config_path,
              UnindexedForeignKeys::Runner => config_path
            }
          end

          def config_path
            %i[linters backend active_record_doctor]
          end
        end
      end
    end
  end
end
