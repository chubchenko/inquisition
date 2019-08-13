require 'inquisition/formatters/html/overview/main_field_builder'
require 'inquisition/formatters/html/overview/breakdowns_builder'
require 'inquisition/formatters/html/overview/coverage_builder'

module Inquisition
  module Formatters
    module Html
      class OverviewBuilder < HtmlBuilder
        def create_erb
          overview = super
          overview_components.each { |component| overview.result(binding { component }) }
          overview
        end

        def file_name
          'overview'
        end

        private

        def overview_components
          [
            Overview::MainFieldBuilder.new(@collection).create_erb.result(binding),
            Overview::BreakdownsBuilder.new(@collection).create_erb.result(binding),
            Overview::CoverageBuilder.new(@collection).create_erb.result(binding)
          ]
        end
      end
    end
  end
end
