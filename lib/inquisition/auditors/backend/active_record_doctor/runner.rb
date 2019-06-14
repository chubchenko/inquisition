module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        class Runner < Core::Runners::MultipleRunner
          private

          def runners
            {
              ExtraneousIndexes::Runner => :extraneous_indexes,
              MissingForeignKeys::Runner => :missing_foreign_keys,
              MissingNonNullConstraint::Runner => :missing_non_null_constraint,
              MissingPresenceValidation::Runner => :missing_presence_validation,
              MissingUniqueIndexes::Runner => :missing_unique_indexes,
              UndefinedTableReferences::Runner => :undefined_table_references,
              UnindexedDeletedAt::Runner => :unindexed_deleted_at,
              UnindexedForeignKeys::Runner => :unindexed_foreign_key
            }
          end
        end
      end
    end
  end
end
