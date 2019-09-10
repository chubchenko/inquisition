module Inquisition
  module Formatters
    module Html
      module Overview
        class BreakdownsBuilder < Builder
          def initialize(collection)
            super
            sort_by_categories
          end

          def file_name
            'breakdowns.html'
          end

          def js_chart
            <<~JS
              <script type="text/javascript">
                var category_percentage = [
                  #{percentage(@categorized_issues[:security])},
                  #{percentage(@categorized_issues[:bug_risk])},
                  #{percentage(@categorized_issues[:performance])},
                  #{percentage(@categorized_issues[:complexity])},
                  #{percentage(@categorized_issues[:unused_code])},
                  #{percentage(@categorized_issues[:duplication])},
                  #{percentage(@categorized_issues[:style])}
                ];
              </script>
            JS
          end

          private

          def sort_by_categories
            grouped_issues = @collection.group_by(&:category)
            @categorized_issues = Hash[grouped_issues.map { |category, issues| [category.name, issues] }]
          end

          def percentage(category)
            return (category.count * 100.00 / @collection.count).round(1) if category

            0
          end
        end
      end
    end
  end
end
