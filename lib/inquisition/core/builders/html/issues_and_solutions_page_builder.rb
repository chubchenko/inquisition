module Inquisition
  module Core
    module Builders
      module Html
        class IssuesAndSolutionsPageBuilder < Core::Builders::BaseHtmlBuilder
          TEMPLATE_PATH = 'lib/inquisition/generators/html/templates/issues_and_solutions.html.haml'.freeze
          PAGE_PRESENTER = Core::Presenters::Pages::IssuesAndSolutionsPagePresenter
        end
      end
    end
  end
end
