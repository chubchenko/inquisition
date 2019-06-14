module Inquisition
  module Core
    module Presenters
      module Data
        module Issues
          class HottestIssuesPresenter < Core::Presenters::StaticPresenter
            AUDITORS = %i[brakeman].freeze
            SORT_ORDER = %w[High Medium].freeze

            private

            def build_presenter
              @build_presenter ||= AUDITORS.map(&method(:build_info)).flatten.sort_by(&method(:sort_by_confidence))
                                           .reject(&:empty?)
            end

            def build_info(auditor)
              AuditorsData.instance.auditor_errors(auditor, :special_info, :hottest_issues)
            end

            def sort_by_confidence(error)
              SORT_ORDER.index(error[:confidence]) || SORT_ORDER.size + 1
            end
          end
        end
      end
    end
  end
end
