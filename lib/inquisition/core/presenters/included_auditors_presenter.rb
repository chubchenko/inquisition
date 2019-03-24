module Inquisition
  module Core
    module Presenters
      class IncludedAuditorsPresenter < BasePresenter
        AUDITOR_GROUP = {
          database: %i[lol_dba active_record_doctor],
          code_smells: %i[rails_best_practices reek rubocop ruby_lint yamllint rubocop-rspec],
          performance: %i[bullet fasterer],
          performances: %i[bullet fasterer],
          secirity: %i[bundler_audit brakeman dawnscanner],
          routes: %i[traceroute],
          diagrams: %i[railroady erd],
          specs_and_coverage: %i[rspec simplecov]
        }.freeze

        UNDEFINED_GROUP = :undefined

        SORT_ORDER = [
          :database,
          :code_smells,
          :performance,
          :performances,
          :secirity,
          :routes,
          :diagrams,
          :specs_and_coverage,
          UNDEFINED_GROUP
        ].freeze

        def all_auditors
          BaseConfig.auditors.values.reduce(&:merge).tap(&:shift).map(&method(:split_by_groups))
                    .group_by { |auditor| auditor[:type] }.sort_by(&method(:sort_by_type)).to_h
        end

        private

        def split_by_groups(auditor_name, params)
          type = auditor_group(auditor_name)
          {
            type: type,
            auditor_name: auditor_name,
            enabled: params[:Enabled]
          }
        end

        def auditor_group(auditor_name)
          AUDITOR_GROUP.select { |_group, auditors| auditors.include?(auditor_name) }.keys.first || UNDEFINED_GROUP
        end

        def sort_by_type(auditor)
          SORT_ORDER.index(auditor.first)
        end
      end
    end
  end
end
