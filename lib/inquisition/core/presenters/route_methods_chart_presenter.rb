module Inquisition
  module Core
    module Presenters
      class RouteMethodsChartPresenter < BasePresenter
        private

        def build_presenter
          RoutesPresenter.new.call.map(&method(:verb_only)).group_by { |route| route[:verb] }
                         .transform_values(&:count).map(&method(:build_count)).sort_by { |method| method[:count] }
                         .reverse.each_with_index.map(&method(:build_chart_keys))
        end

        def build_chart_keys(route, index)
          {
            name: route[:method].downcase.capitalize + 'able',
            count: route[:count],
            chart_color: CIRCLE_CHART_COLORS[index]
          }
        end

        def verb_only(route)
          route.slice(:verb)
        end

        def build_count(method, count)
          {
            method: method,
            count: count
          }
        end
      end
    end
  end
end
