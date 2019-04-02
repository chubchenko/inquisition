module Inquisition
  module Core
    module Presenters
      module Elements
        module Html
          module Dynamic
            class CircleChartPresenter < Core::Presenters::DynamicPresenter
              CIRCLE_CHART_COLORS = %i[blue gray purple red neagara].freeze

              def add_body_item
                element[:body] << item_structure
                add_color
              end

              def add_title(title)
                element[:title] = title
              end

              def generate_element_id_by_class(klass)
                element[:element_id] = klass.to_s.split('::').last
              end

              def add_chart_header(header)
                element[:chart_header] = header
              end

              def add_name_header(header)
                element[:name_header] = header
              end

              def add_total_header(header)
                element[:total_header] = header
              end

              def add_body_name(name)
                element[:body][item_index][:name] = name
              end

              def add_body_total(total)
                element[:body][item_index][:total] = total
              end

              def add_color
                element[:body][item_index][:color] = CIRCLE_CHART_COLORS[item_index]
              end

              def item_index
                element[:body].size - 1
              end

              def element
                @element ||= element_structure
              end

              private

              def element_structure
                {
                  title: '',
                  element_id: '',
                  chart_header: '',
                  name_header: '',
                  total_header: '',
                  body: []
                }
              end

              def item_structure
                {
                  name: '',
                  total: '',
                  color: ''
                }
              end
            end
          end
        end
      end
    end
  end
end
