module Inquisition
  module Outputter
    class HTML
      module Overview
        class BreakdownsBuilder < Builder
          def file_name
            'breakdowns.html'
          end

          def js_chart
            <<~JS
              <script type="text/javascript">
                var category_percentage = #{percents_per_category};
              </script>
            JS
          end

          private

          def percents_per_category
            group_issues
            Inquisition::Category::NAMES.map { |category| percentage(@categorized_issues[category]) }
          end

          def group_issues
            grouped_issues = @collection.group_by { |issue| issue.category.name }
            @categorized_issues = Hash.new([]).update(grouped_issues)
          end

          def percentage(issues)
            return 0 if issues.empty?

            (issues.count * 100.0 / @collection.count).round(2)
          end
        end
      end
    end
  end
end
