module Inquisition
  module Formatters
    module Html
      class OverviewBuilder < HtmlBuilder
        def file_name
          'overview.html.erb'
        end
      end
    end
  end
end
