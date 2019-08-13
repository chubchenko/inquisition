module Inquisition
  module Formatters
    module Html
      module Overview
        class CoverageBuilder < HtmlBuilder
          def file_name
            'coverage'
          end

          def erb_variable
            '@coverage'
          end
        end
      end
    end
  end
end
