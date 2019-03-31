module Inquisition
  module Core
    module Builders
      module Html
        class DatabaseSummaryPageBuilder < Core::Builders::BaseHtmlBuilder
          TEMPLATE_PATH = 'lib/inquisition/generators/html/templates/database_summary.html.haml'.freeze
          PAGE_PRESENTER = Core::Presenters::Pages::Html::DatabaseSummaryPagePresenter
        end
      end
    end
  end
end
