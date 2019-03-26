module Inquisition
  module Core
    module Builders
      module Html
        class CommonPageBuilder < Core::Builders::BaseHtmlBuilder
          TEMPLATE_PATH = 'lib/inquisition/generators/html/templates/common.html.haml'.freeze
          PAGE_PRESENTER = Core::Presenters::Pages::CommonPagePresenter
        end
      end
    end
  end
end
