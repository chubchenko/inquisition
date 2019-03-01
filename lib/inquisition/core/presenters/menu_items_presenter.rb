module Inquisition
  module Core
    module Presenters
      class MenuItemsPresenter < BasePresenter
        private

        def build_presenter
          build_item_tree('Backend') if include_path?(:backend)
          build_item_tree('Frontend') if include_path?(:frontend)
          build_item_tree('Common') if include_path?(:common)
        end

        def build_item_tree(name)
          item_name = name.downcase
          @presenter[item_name] = build_item(name)
          @presenter[item_name][:child_items] = build_nested_level(name).compact
        end

        def build_nested_level(name)
          BaseConfig.auditors[name.downcase.to_sym].map do |auditor, status|
            build_item(auditor.to_s) if status.is_a?(Hash) && status[:Enabled]
          end
        end

        def build_item(name)
          Core::Presenters::MenuItemPresenter.new(name).call
        end

        def include_path?(path)
          BaseConfig.config_enabled?(:linters, path)
        end
      end
    end
  end
end
