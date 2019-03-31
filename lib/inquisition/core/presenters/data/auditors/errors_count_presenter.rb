module Inquisition
  module Core
    module Presenters
      module Data
        module Auditors
          class ErrorsCountPresenter < Core::Presenters::StaticPresenter
            ERRORS_TYPE = [
              {
                type: 'Code Smells',
                auditors: %i[fasterer reek dawnscanner rails_best_practices rubocop ruby_lint yamllint]
              },
              {
                type: 'Security',
                auditors: %i[bundler_audit brakeman]
              },
              {
                type: 'Database',
                auditors: %i[
                  lol_dba
                  extraneous_indexes
                  missing_foreign_keys
                  missing_non_null_constraint
                  missing_presence_validation
                  missing_unique_indexes
                  undefined_table_references
                  unindexed_deleted_at
                  unindexed_foreign_key
                ]
              }
            ].freeze

            private

            def build_presenter
              @build_presenter ||= ERRORS_TYPE.map do |error|
                {
                  error_type: error[:type],
                  error_count: count_errors(error[:auditors])
                }
              end
            end

            def count_errors(auditors)
              auditors.map(&method(:error_count_key)).compact.sum
            end

            def error_count_key(auditor)
              AuditorsData.instance.auditor_errors(auditor)[:error_count]
            end
          end
        end
      end
    end
  end
end
