module Inquisition
  module Formatters
    module Html
      module Overview
        class BreakdownsBuilder < HtmlBuilder
          def file_name
            'breakdowns'
          end

          def erb_variable
            '@breakdowns'
          end
        end
      end
    end
  end
end
