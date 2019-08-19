module Inquisition
  module Formatters
    module Html
      module Overview
        class BreakdownsBuilder < HtmlBuilder
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
                  #{percentage(@categorized_issues[:style])},
                  #{percentage(@categorized_issues[:performance])},
                  #{percentage(@categorized_issues[:compatibility])},
                  #{percentage(@categorized_issues[:unused_code])},
                  #{percentage(@categorized_issues[:duplication])}
                ];
              </script>
            JS
          end

          private

          def sort_by_categories
            @categorized_issues = { security: [], style: [], performance: [], compatibility: [],
                                    unused_code: [], duplication: [] } # remove when category will be added

            # @categorized_issues = @collection.group_by(&:category)
          end

          def percentage(category)
            # category.count * 100 / @collection.count
          end
        end
      end
    end
  end
end
