module Inquisition
  module Core
    module Presenters
      module Pages
        class CommonPagePresenter < PagePresenter
          attr_reader :auditor_data

          def initialize(auditiors_tree, page_name)
            super
            @auditor_data = @auditors_tree.dig(:backend, page_name, :errors) || []
          end

          def auditor_page_name
            page_name.to_s.humanize
          end

          def total_errors
            auditor_data.count
          end
        end
      end
    end
  end
end
