module Inquisition
  module Core
    module Presenters
      class PagePresenter < BasePresenter
        def initialize(auditors_tree)
          @auditors_tree = auditors_tree
        end

        def menu_items
          Core::Presenters::MenuItemsPresenter.new.call
        end
      end
    end
  end
end
