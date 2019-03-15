module Inquisition
  module Core
    module Presenters
      class MenuItemsPresenter < BasePresenter
        DATABASE_SUMMARY_PAGE = 'database_summary.html'.freeze

        private

        def build_presenter
          build_item_tree('Backend') if include_path?(:backend)
          build_item_tree('Frontend') if include_path?(:frontend)
          build_item_tree('Common') if include_path?(:common)
          build_additional_items
          @items
        end

        def build_additional_items
          build_database_summary_page if include_path?(:backend)
        end

        def build_database_summary_page
          @items['backend'][:child_items] << build_item('database summary', DATABASE_SUMMARY_PAGE)
        end

        def build_item_tree(name)
          item_name = name.downcase
          @items ||= {}
          @items[item_name] = build_item(name)
          @items[item_name][:child_items] = build_nested_level(name).compact
        end

        def build_nested_level(name)
          BaseConfig.auditors[name.downcase.to_sym].map do |auditor, status|
            build_item(auditor.to_s) if status.is_a?(Hash) && status[:Enabled]
          end
        end

        def build_item(name, link = '#need_change')
          Core::Presenters::MenuItemPresenter.new(name: name, link: link).call
        end

        def include_path?(path)
          BaseConfig.config_enabled?(:linters, path)
        end
      end
    end
  end
end
