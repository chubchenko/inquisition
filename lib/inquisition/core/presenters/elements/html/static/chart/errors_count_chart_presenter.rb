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
                  element_presenter.element
                end

                def add_items
                  data.each do |item|
                    element_presenter.add_item
                    element_presenter.add_name(item[:error_type])
                    element_presenter.add_total(item[:error_count])
                  end
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
