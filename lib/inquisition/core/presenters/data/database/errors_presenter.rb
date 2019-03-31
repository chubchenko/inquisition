module Inquisition
  module Core
    module Presenters
      module Data
        module Database
          class ErrorsPresenter < Presenters::StaticPresenter
            private

            def build_presenter
              @build_presenter ||= AuditorsPresenter::AUDITORS.map(&method(:auditor_errors)).inject(&:merge)
            end

            def auditor_errors(auditor)
              {
                auditor => AuditorsData.instance.auditor_errors(auditor)
              }
            end
          end
        end
      end
    end
  end
end
