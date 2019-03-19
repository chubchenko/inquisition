module Inquisition
  module Core
    module Presenters
      class IssuesPipelinePresenter < BasePresenter
        ISSUES_PIPELINE_AUDITORS = [
          %i[backend reek],
          %i[backend reek],
          %i[backend reek]
        ].freeze

        private

        def build_presenter
          {
            total: issues_info.count,
            issues: issues_info
          }
        end

        def issues_info
          @issues_info ||= ISSUES_PIPELINE_AUDITORS.map(&method(:build_issues_info)).flatten
        end

        def build_issues_info(auditor_path)
          @data.dig(*auditor_path, :special_info, :issues)
        end
      end
    end
  end
end
