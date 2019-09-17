require_relative 'overview/main_field_builder'
require_relative 'overview/breakdowns_builder'
require_relative 'overview/coverage_builder'

module Inquisition
  module Outputter
    class HTML
      class OverviewBuilder < Builder
        def file_name
          'overview.html'
        end

        def main_field
          Overview::MainFieldBuilder.new(collection)
        end

        def breakdowns
          Overview::BreakdownsBuilder.new(collection)
        end

        def coverage
          Overview::CoverageBuilder.new(collection)
        end
      end
    end
  end
end
