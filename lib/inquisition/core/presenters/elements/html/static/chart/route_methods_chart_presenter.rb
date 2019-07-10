module Inquisition
  module Core
    module Presenters
      module Elements
        module Html
          module Static
            module Chart
              class RouteMethodsChartPresenter < Core::Presenters::StaticPresenter
                private

                def build_presenter
                  @build_presenter ||= build_chart
                end

                def build_chart
                  build_chart_items
                  element_presenter.element
                end

                def build_chart_items
                  data.group_by { |route| route[:verb] }.transform_values(&:count).sort_by { |_verb, count| count }
                      .reverse_each(&method(:build_chart_hash))
                end

                def build_chart_hash(item)
                  element_presenter.add_item
                  element_presenter.add_name(item.first)
                  element_presenter.add_total(item.last)
                end

                def element_presenter
                  @element_presenter ||= Elements::Html::Dynamic::CircleChartPresenter.new
                end

                def data
                  @data ||= Data::Common::RoutesPresenter.instance.call
                end
              end
            end
          end
        end
      end
    end
  end
end
