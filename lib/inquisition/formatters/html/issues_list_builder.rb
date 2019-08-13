module Inquisition
  module Formatters
    module Html
      class IssuesListBuilder < HtmlBuilder
        def file_name
          'issues_list.html.erb'
        end
      end
    end
  end
end
