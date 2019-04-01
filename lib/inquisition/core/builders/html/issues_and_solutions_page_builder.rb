module Inquisition
  module Core
    module Builders
      module Html
        class IssuesAndSolutionsPageBuilder < Core::Builders::BaseHtmlBuilder
          TEMPLATE = 'pages/issues_and_solutions.html.haml'.freeze
          PAGE_PRESENTER = Core::Presenters::Pages::Html::IssuesAndSolutionsPagePresenter
        end
      end
    end
  end
end
