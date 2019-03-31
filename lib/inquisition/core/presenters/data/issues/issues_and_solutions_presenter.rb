module Inquisition
  module Core
    module Presenters
      module Data
        module Issues
          class IssuesAndSolutionsPresenter < Core::Presenters::StaticPresenter
            AUDITORS = %i[reek].freeze

            private

            def build_presenter
              @build_presenter ||= AUDITORS.map(&method(:build_issues_info)).flatten.reject(&:empty?)
            end

            def build_issues_info(auditor)
              AuditorsData.instance.auditor_errors(auditor, :special_info, :issues)
            end
          end
        end
      end
    end
  end
end
