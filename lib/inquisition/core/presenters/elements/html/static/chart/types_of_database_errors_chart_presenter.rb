module Inquisition
  module Core
    module Presenters
      module Elements
        module Html
          module Static
            module Chart
              class TypesOfDatabaseErrorsChartPresenter < Core::Presenters::StaticPresenter
                NUMBER_OF_ITEMS = 5

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
                  data.first(NUMBER_OF_ITEMS).map(&method(:build_chart_element))
                end

                def build_chart_element(item)
                  element_presenter.add_body_item
                  element_presenter.add_body_name(item.first)
                  element_presenter.add_body_total(item.last)
                end

                def add_additional_items
                  element_presenter.generate_element_id_by_class(self.class)
                  element_presenter.add_title(I18n.t('elements.chart.types_errors.title'))
                  element_presenter.add_chart_header(I18n.t('elements.chart.types_errors.chart_header'))
                  element_presenter.add_name_header(I18n.t('elements.chart.types_errors.name_header'))
                  element_presenter.add_total_header(I18n.t('elements.chart.types_errors.total_header'))
                end

                def element_presenter
                  @element_presenter ||= Elements::Html::Dynamic::CircleChartPresenter.new
                end

                def data
                  @data ||= errors.collect { |_auditor, value| value[:errors] }.flatten.compact
                                  .group_by { |error| error[:type] }.transform_values(&:count)
                                  .sort_by { |_verb, count| count }.reverse
                end

                def errors
                  @errors ||= Data::Database::ErrorsPresenter.instance.call
                end
              end
            end
          end
        end
      end
    end
  end
end
