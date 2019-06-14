module Inquisition
  module Core
    module Presenters
      module Data
        module Database
          class AuditorsPresenter < Presenters::StaticPresenter
            AUDITORS = %i[
              missing_foreign_keys
              missing_non_null_constraint
              missing_presence_validation
              missing_unique_indexes
              undefined_table_references
              unindexed_deleted_at
              unindexed_foreign_key
              lol_dba
            ].freeze

            private

            def build_presenter
              @build_presenter ||= AUDITORS.map(&method(:check_enabled))
            end

            def check_enabled(auditor)
              {
                auditor: auditor,
                enabled: BaseConfig.instance.auditor_enabled?(auditor)
              }
            end
          end
        end
      end
    end
  end
end
