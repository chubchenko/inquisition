module Inquisition
  module Core
    module Presenters
      module Elements
        module Html
          module Dynamic
            class TablePresenter < Core::Presenters::DynamicPresenter
              ELEMENT_STRUCTURE = {
                headers: [],
                body: []
              }.freeze

              def add_headers(headers)
                element[:headers] = headers
              end

              def add_body_item(item)
                element[:body] << item
              end

              def add_body_items(array_of_items)
                element[:body] = array_of_items
              end

              def element
                @element ||= ELEMENT_STRUCTURE.dup
              end
            end
          end
        end
      end
    end
  end
end
