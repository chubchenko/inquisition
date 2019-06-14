module Inquisition
  module Core
    module Builders
      module Html
        class IndexPageBuilder < Core::Builders::BaseHtmlBuilder
          TEMPLATE = 'pages/index.html.haml'.freeze
          PAGE_PRESENTER = Core::Presenters::Pages::Html::IndexPagePresenter
        end
      end
    end
  end
end
