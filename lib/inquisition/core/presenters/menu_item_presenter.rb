module Inquisition
  module Core
    module Presenters
      class MenuItemPresenter < BasePresenter
        def initialize(name)
          @name = name
        end

        private

        def build_presenter
          @presenter = {
            'item_name': @name,
            'link': '#need_change'
          }
        end
      end
    end
  end
end
