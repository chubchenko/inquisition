module Inquisition
  module Core
    module Presenters
      class HottestIssuesPresenter < BasePresenter
        ISSUES_AUDITORS = [
          %i[backend brakeman]
        ].freeze
        SORT_ORDER = %w[High Medium].freeze

        private

        def build_presenter
          {
            total: issues_info.count,
            issues: issues_info
          }
        end

        def issues_info
          @issues_info ||= ISSUES_AUDITORS.map(&method(:build_info)).flatten.sort_by(&method(:sort_by_confidence))
        end

        def build_info(auditor_path)
          @data.dig(*auditor_path, :special_info, :hottest_issues) || []
        end

        def sort_by_confidence(error)
          SORT_ORDER.index(error[:confidence]) || SORT_ORDER.size + 1
        end
      end
    end
  end
end
