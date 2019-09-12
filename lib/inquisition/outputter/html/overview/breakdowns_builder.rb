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

          def categorized_issues
            @categorized_issues ||= Hash[
              group_issues.map do |category, issues|
                [category.name, issues]
              end
            ]
          end

          private

          def percents_per_category
            Inquisition::Category::NAMES.map { |category| percentage(categorized_issues[category]) }
          end

          def group_issues
            @collection.group_by(&:category)
          end

          def percentage(issues)
            # return 0 if issues.empty?
            return 0 unless issues

            (issues.count * 100.0 / @collection.count).round(2)
          end
        end
      end
    end
  end
end
