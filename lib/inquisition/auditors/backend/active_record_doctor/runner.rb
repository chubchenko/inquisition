module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        class Runner < Core::Runners::MultipleRunner
          private

          def runners
            {
              Runners::ExtraneousIndexesRunner => config_path,
              Runners::MissingForeignKeysRunner => config_path,
              Runners::MissingNonNullConstraintRunner => config_path,
              Runners::MissingPresenceValidationRunner => config_path,
              Runners::MissingUniqueIndexesRunner => config_path,
              Runners::UndefinedTableReferencesRunner => config_path,
              Runners::UnindexedDeletedAtRunner => config_path,
              Runners::UnindexedForeignKeysRunner => config_path
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
