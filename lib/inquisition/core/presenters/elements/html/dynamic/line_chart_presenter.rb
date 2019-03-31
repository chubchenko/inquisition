module Inquisition
  module Core
    module Presenters
      module Elements
        module Html
          module Dynamic
            class LineChartPresenter < Core::Presenters::DynamicPresenter
              ELEMENT_STRUCTURE = {
                title: '',
                number: '',
                total: '',
                percent: ''
              }.freeze

              def add_item
                element << ELEMENT_STRUCTURE.dup
              end

              def add_title(title)
                element[item_index][:title] = title
              end

              def add_number(number)
                element[item_index][:number] = number
              end

              def add_total(total)
                element[item_index][:total] = total
              end

              def add_percent
                element[item_index][:percent] = percent
              end

              def percent
                element[item_index][:total].zero? ? 0 : calculate_percent
              end

              def calculate_percent
                item = element[item_index]
                100 * item[:number] / item[:total]
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
