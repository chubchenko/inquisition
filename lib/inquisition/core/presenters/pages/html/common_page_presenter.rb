module Inquisition
  module Core
    module Presenters
      module Pages
        module Html
          class CommonPagePresenter < HtmlPagePresenter
            def auditor_page_name
              page_name.to_s.humanize
            end

            def total_errors
              data[:error_count]
            end

            def data
              @data ||= AuditorsData.instance.auditor_errors(page_name)
            end
          end
        end
      end
    end
  end
end
