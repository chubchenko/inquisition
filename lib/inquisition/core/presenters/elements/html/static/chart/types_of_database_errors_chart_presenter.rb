module Inquisition
  module Core
    module Presenters
      module Elements
        module Html
          module Static
            module Chart
              class TypesOfDatabaseErrorsChartPresenter < Core::Presenters::StaticPresenter
                private

                def build_presenter
                  @build_presenter ||= build_chart
                end

                def build_chart
                  data.map(&method(:build_chart_element))
                  element_presenter.element
                end

                def build_chart_element(item)
                  element_presenter.add_item
                  element_presenter.add_name(item.first)
                  element_presenter.add_total(item.last)
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
