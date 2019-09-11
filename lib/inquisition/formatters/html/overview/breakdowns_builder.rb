module Inquisition
  module Formatters
    module HTML
      module Overview
        class BreakdownsBuilder < Builder
          def file_name
            'breakdowns.html'
          end

          def js_chart
            <<~JS
              <script type="text/javascript">
                var category_percentage = [
                  #{percentage(categorized_issues[:security])},
                  #{percentage(categorized_issues[:bug_risk])},
                  #{percentage(categorized_issues[:performance])},
                  #{percentage(categorized_issues[:complexity])},
                  #{percentage(categorized_issues[:unused_code])},
                  #{percentage(categorized_issues[:duplication])},
                  #{percentage(categorized_issues[:style])}
                ];
              </script>
            JS
          end

          def categorized_issues
            @categorized_issues ||= Hash[
              group_issues.map do |category, issues|
                [category.name, issues]
              end
            ]
          end

          private

          def group_issues
            @collection.group_by(&:category)
          end

          def percentage(issues)
            return (issues.count * 100.00 / @collection.count).round(1) if issues

            0
          end
        end
      end
    end
  end
end
