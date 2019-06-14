module Inquisition
  module Core
    module Presenters
      module Pages
        module Html
          class HottestIssuesPagePresenter < HtmlPagePresenter
            def issues
              Data::Issues::HottestIssuesPresenter.instance.call
            end

            def total_issues
              issues.count
            end
          end
        end
      end
    end
  end
end
