module Inquisition
  module Outputter
    module HtmlOutput
      module Overview
        class MainFieldBuilder < Builder
          def file_name
            'main_field.html'
          end

          def sorted_issues
            @collection.group_by(&:runner)
          end

          def percentage(issues)
            (issues.count * 100.00 / @collection.count).round(1)
          end
        end
      end
    end
  end
end
