module Inquisition
  module Formatters
    module Html
      module Overview
        class CoverageBuilder < HtmlBuilder
          def file_name
            'coverage.html'
          end
        end
      end
    end
  end
end
