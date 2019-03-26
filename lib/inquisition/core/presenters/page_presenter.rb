module Inquisition
  module Core
    module Presenters
      class PagePresenter < BasePresenter
        attr_reader :page_name

        def initialize(auditors_tree, page_name)
          @auditors_tree = auditors_tree
          @page_name = page_name
        end

        def menu_items
          Core::Presenters::MenuItemsPresenter.new.call
        end
      end
    end
  end
end
