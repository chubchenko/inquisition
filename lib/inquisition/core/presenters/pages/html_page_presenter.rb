module Inquisition
  module Core
    module Presenters
      module Pages
        class HtmlPagePresenter
          include Partials::HtmlPartial

          attr_reader :page_name

          def initialize(page_name = nil)
            @page_name = page_name
          end

          def menu_items
            Elements::Html::Static::Menu::MenuItemsPresenter.instance.call
          end

          def additional_javascript
            partial(js_partial, presenter: self) if js_partial_exist?
          end

          private

          def js_partial
            @js_partial ||= "js/#{page_name}.js.haml"
          end

          def js_partial_exist?
            File.file?(File.join(partials_path, js_partial))
          end
        end
      end
    end
  end
end
