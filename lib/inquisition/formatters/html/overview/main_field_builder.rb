module Inquisition
  module Formatters
    module Html
      module Overview
        class MainFieldBuilder < HtmlBuilder
          def file_name
            'main_field'
          end

          def erb_variable
            '@main_field'
          end
        end
      end
    end
  end
end
