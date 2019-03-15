module Inquisition
  module Core
    module Presenters
      class MenuItemPresenter < BasePresenter
        private

        def build_presenter
          {
            'item_name': @data[:name],
            'link': @data[:link]
          }
        end
      end
    end
  end
end
