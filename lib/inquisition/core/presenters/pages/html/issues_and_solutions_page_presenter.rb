module Inquisition
  module Core
    module Presenters
      module Pages
        module Html
          class IssuesAndSolutionsPagePresenter < HtmlPagePresenter
            def issues
              Data::Issues::IssuesAndSolutionsPresenter.instance.call
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
