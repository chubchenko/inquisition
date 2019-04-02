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
                  add_items
                  add_additional_items
                  element_presenter.element
                end

                def add_items
                  data.group_by { |route| route[:verb] }.transform_values(&:count).sort_by { |_verb, count| count }
                      .reverse.each(&method(:build_chart_hash))
                end

                def build_chart_hash(item)
                  element_presenter.add_body_item
                  element_presenter.add_body_name(item.first + I18n.t('elements.chart.route_methods.additional_name'))
                  element_presenter.add_body_total(item.last)
                end

                def add_additional_items
                  element_presenter.generate_element_id_by_class(self.class)
                  element_presenter.add_title(I18n.t('elements.chart.route_methods.title'))
                  element_presenter.add_chart_header(I18n.t('elements.chart.route_methods.chart_header'))
                  element_presenter.add_name_header(I18n.t('elements.chart.route_methods.name_header'))
                  element_presenter.add_total_header(I18n.t('elements.chart.route_methods.total_header'))
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
