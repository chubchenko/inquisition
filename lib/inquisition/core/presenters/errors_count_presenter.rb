module Inquisition
  module Core
    module Presenters
      class ErrorsCountPresenter < BasePresenter
        ERRORS_TYPE = [
          {
            type: 'code smells',
            auditors: [
              %i[backend fasterer],
              %i[backend reek],
              %i[backend dawnscanner],
              %i[backend rails_best_practices],
              %i[backend rubocop],
              %i[backend ruby_lint],
              %i[backend yamllint]
            ]
          },
          {
            type: 'security',
            auditors: [
              %i[backend bundler_audit],
              %i[backend brakeman]
            ]
          },
          {
            type: 'database',
            auditors: [
              %i[backend lol_dba],
              %i[backend active_record_doctor extraneous_indexes],
              %i[backend active_record_doctor missing_foreign_keys],
              %i[backend active_record_doctor missing_non_null_constraint],
              %i[backend active_record_doctor missing_presence_validation],
              %i[backend active_record_doctor missing_unique_indexes],
              %i[backend active_record_doctor undefined_table_references],
              %i[backend active_record_doctor unindexed_deleted_at],
              %i[backend active_record_doctor unindexed_foreign_keys]
            ]
          }
        ].freeze

        private

        def build_presenter
          ERRORS_TYPE.each_with_index.map do |error, index|
            error_count = count_errors(error[:auditors])
            {
              error_name: error[:type],
              error_count: error_count,
              chart_color: CIRCLE_CHART_COLORS[index]
            }
          end
        end

        def count_errors(auditors)
          auditors.map { |auditor| @data.dig(*auditor, :error_count) }.compact.sum
        end
      end
    end
  end
end
