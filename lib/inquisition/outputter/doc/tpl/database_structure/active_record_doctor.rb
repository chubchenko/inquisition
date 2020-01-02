module Inquisition
  module Outputter
    class Doc
      module TPL
        class DatabaseStructure
          class ActiveRecordDoctor
            class Wrapper < SimpleDelegator
              EXPLANATIONS = {
                'MissingForeignKeys' => 'missing foreign key constraints',
                'ExtraneousIndexes' => 'extraneous indexes',
                'MissingNonNullConstraint' => 'missing non-NULL constraints',
                'MissingPresenceValidation' => 'missing presence validations',
                'MissingUniqueIndexes' => 'uniqueness validations not backed by an index',
                'UndefinedTableReferences' => 'missing references',
                'UnindexedDeletedAt' => 'unindexed deleted_at columns',
                'UnindexedForeignKeys' => 'unindexed foreign keys'
              }.freeze

              def group
                group_by(&:context).each do |warning, issues|
                  yield(EXPLANATIONS[warning], issues.count)
                end
              end
            end

            def self.call(issues)
              new(
                Wrapper.new(Security::Collector.new(issues, ::Inquisition::ActiveRecordDoctor::Runner).call)
              )
            end

            attr_reader :collection

            def initialize(collection)
              @collection = collection
            end

            def produce
              binding
            end
          end
        end
      end
    end
  end
end
