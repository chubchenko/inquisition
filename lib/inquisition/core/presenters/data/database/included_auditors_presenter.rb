module Inquisition
  module Core
    module Presenters
      module Data
        module Database
          class IncludedAuditorsPresenter < Presenters::StaticPresenter
            private

            def build_presenter
              @build_presenter ||= auditors.select { |auditor| auditor[:enabled] }
            end

            def auditors
              Data::Database::AuditorsPresenter.instance.call
            end
          end
        end
      end
    end
  end
end
