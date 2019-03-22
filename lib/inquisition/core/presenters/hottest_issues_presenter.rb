module Inquisition
  module Core
    module Presenters
      class HottestIssuesPresenter < BasePresenter
        HOTTEST_ISSUES_AUDITORS = [
          %i[backend brakeman]
        ].freeze

        private

        def build_presenter
          {
            total: issues_info.count,
            issues: issues_info
          }
        end

        def issues_info
          @issues_info ||= HOTTEST_ISSUES_AUDITORS.map(&method(:build_issues_info)).flatten
        end

        def build_issues_info(auditor_path)
          @data.dig(*auditor_path, :special_info, :hottest_issues)
        end
      end
    end
  end
end
