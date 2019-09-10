require 'inquisition/formatters/html/overview/main_field_builder'
require 'inquisition/formatters/html/overview/breakdowns_builder'
require 'inquisition/formatters/html/overview/coverage_builder'

module Inquisition
  module Formatters
    module HTML
      class OverviewBuilder < Builder
        def file_name
          'overview.html'
        end

        def main_field
          Overview::MainFieldBuilder.new(@collection)
        end

        def breakdowns
          Overview::BreakdownsBuilder.new(@collection)
        end

        def coverage
          Overview::CoverageBuilder.new(@collection)
        end
      end
    end
  end
end
