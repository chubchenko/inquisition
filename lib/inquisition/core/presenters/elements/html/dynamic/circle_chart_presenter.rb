module Inquisition
  module Core
    module Presenters
      module Elements
        module Html
          module Dynamic
            class CircleChartPresenter < Core::Presenters::DynamicPresenter
              CIRCLE_CHART_COLORS = %i[blue gray purple red neagara].freeze
              ELEMENT_STRUCTURE = {
                name: '',
                total: '',
                color: ''
              }.freeze

              def add_item
                element << ELEMENT_STRUCTURE.dup
                add_color
              end

              def add_name(name)
                element[item_index][:name] = name
              end

              def add_total(total)
                element[item_index][:total] = total
              end

              def add_color
                element[item_index][:color] = CIRCLE_CHART_COLORS[item_index]
              end

              def item_index
                element.size - 1
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
