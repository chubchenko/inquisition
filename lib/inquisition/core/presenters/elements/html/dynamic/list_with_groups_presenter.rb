module Inquisition
  module Core
    module Presenters
      module Elements
        module Html
          module Dynamic
            class ListWithGroupsPresenter < Core::Presenters::DynamicPresenter
              ELEMENT_STRUCTURE = {
                group_name: '',
                items: []
              }.freeze

              def add_group(group)
                element << ELEMENT_STRUCTURE.dup
                element[current_item_index][:group_name] = group
              end

              def add_items(array_of_items)
                element[current_item_index][:items] = array_of_items
              end

              def current_item_index
                element.size - 1
              end

              def sort_by_groups(sort_order)
                element.sort_by do |auditor|
                  sort_order.index(auditor[:group_name]) || sort_order.size + 1
                end
              end

              def element
                @element ||= []
              end
            end
          end
        end
      end
    end
  end
end
