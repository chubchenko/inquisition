module Inquisition
  module Formatters
    module HTML
      module Overview
        class MainFieldBuilder < Builder
          def initialize(collection)
            super
            sort_by_runners
          end

          def file_name
            'main_field.html'
          end

          private

          def sort_by_runners
            @sorted_issues = @collection.group_by(&:runner)
          end

          def percentage(issues)
            (issues * 100.00 / @collection.count).round(1)
          end
        end
      end
    end
  end
end
