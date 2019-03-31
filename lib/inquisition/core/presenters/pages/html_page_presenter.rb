module Inquisition
  module Core
    module Presenters
      module Pages
        class HtmlPagePresenter
          attr_reader :page_name

          def initialize(page_name = nil)
            @page_name = page_name
          end

          def menu_items
            Elements::Html::Static::Menu::MenuItemsPresenter.instance.call
          end
        end
      end
    end
  end
end
