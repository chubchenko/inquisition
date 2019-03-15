module Inquisition
  module Core
    module Builders
      module Html
        class IndexPageBuilder < Core::Builders::BaseHtmlBuilder
          TEMPLATE_PATH = 'lib/inquisition/generators/html/templates/index.html.haml'.freeze
          PAGE_PRESENTER = Core::Presenters::Pages::IndexPagePresenter
        end
      end
    end
  end
end
