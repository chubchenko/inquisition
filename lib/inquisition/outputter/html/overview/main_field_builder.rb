module Inquisition
  module Outputter
    class HTML
      module Overview
        class MainFieldBuilder < Builder
          def file_name
            'main_field.html'
          end

          def sorted_issues
            @collection.group_by(&:runner)
          end

          def percentage(issues)
            (issues.count * 100.0 / @collection.count).round(2)
          end
        end
      end
    end
  end
end
