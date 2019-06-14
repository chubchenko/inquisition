module Inquisition
  module Core
    module Presenters
      module Data
        module Auditors
          class AuditorsPresenter < Core::Presenters::StaticPresenter
            private

            def build_presenter
              @build_presenter ||= auditors_list
            end
          end
        end
      end
    end
  end
end
