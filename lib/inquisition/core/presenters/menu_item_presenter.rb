module Inquisition
  module Core
    module Presenters
      class MenuItemPresenter < BasePresenter
        private

        def build_presenter
          name = @data[:name]
          {
            name: name,
            link: @data[:link],
            class: name.split.map(&:downcase).join('_')
          }
        end
      end
    end
  end
end
