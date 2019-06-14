module Inquisition
  module Core
    module Builders
      module Html
        class CommonPageBuilder < Core::Builders::BaseHtmlBuilder
          TEMPLATE = 'pages/common.html.haml'.freeze
          PAGE_PRESENTER = Core::Presenters::Pages::Html::CommonPagePresenter
        end
      end
    end
  end
end
