module Inquisition
  module Core
    module Presenters
      module Elements
        module Html
          module Static
            module Chart
              class ErrorsCountChartPresenter < Core::Presenters::StaticPresenter
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
                  data.each do |item|
                    element_presenter.add_body_item
                    element_presenter.add_body_name(item[:error_type] + additional_name)
                    element_presenter.add_body_total(item[:error_count])
                  end
                end

                def add_additional_items
                  element_presenter.generate_element_id_by_class(self.class)
                  element_presenter.add_title(I18n.t('elements.chart.errors_count.title'))
                  element_presenter.add_chart_header(I18n.t('elements.chart.errors_count.chart_header'))
                  element_presenter.add_name_header(I18n.t('elements.chart.errors_count.name_header'))
                  element_presenter.add_total_header(I18n.t('elements.chart.errors_count.total_header'))
                end

                def additional_name
                  I18n.t('elements.chart.route_methods.additional_name')
                end

                def element_presenter
                  @element_presenter ||= Elements::Html::Dynamic::CircleChartPresenter.new
                end

                def data
                  @data ||= Data::Auditors::ErrorsCountPresenter.instance.call
                end
              end
            end
          end
        end
      end
    end
  end
end
