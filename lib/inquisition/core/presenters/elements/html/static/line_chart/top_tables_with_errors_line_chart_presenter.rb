module Inquisition
  module Core
    module Presenters
      module Elements
        module Html
          module Static
            module LineChart
              class TopTablesWithErrorsLineChartPresenter < Core::Presenters::StaticPresenter
                private

                def build_presenter
                  @build_presenter ||= build_chart
                end

                def build_chart
                  add_items
                  element_presenter.element
                end

                def add_items
                  data.each do |item|
                    element_presenter.add_item
                    element_presenter.add_title(item.first)
                    element_presenter.add_number(item.last)
                    element_presenter.add_total(total_errors)
                    element_presenter.add_percent
                  end
                end

                def element_presenter
                  @element_presenter ||= Elements::Html::Dynamic::LineChartPresenter.new
                end

                def data
                  @data ||= errors.collect { |_auditor, value| value[:errors] }.flatten.compact
                                  .group_by { |error| error[:table] }.transform_values(&:count)
                                  .sort_by { |_verb, count| count }.reverse
                end

                def total_errors
                  @total_errors ||= errors.count
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
