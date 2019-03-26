module Inquisition
  module Core
    module Builders
      module Html
        class HottestIssuesPageBuilder < Core::Builders::BaseHtmlBuilder
          TEMPLATE_PATH = 'lib/inquisition/generators/html/templates/hottest_issues.html.haml'.freeze
          PAGE_PRESENTER = Core::Presenters::Pages::HottestIssuesPagePresenter
        end
      end
    end
  end
end
