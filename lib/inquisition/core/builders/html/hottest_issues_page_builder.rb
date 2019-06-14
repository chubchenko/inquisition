module Inquisition
  module Core
    module Builders
      module Html
        class HottestIssuesPageBuilder < Core::Builders::BaseHtmlBuilder
          TEMPLATE = 'pages/hottest_issues.html.haml'.freeze
          PAGE_PRESENTER = Core::Presenters::Pages::Html::HottestIssuesPagePresenter
        end
      end
    end
  end
end
