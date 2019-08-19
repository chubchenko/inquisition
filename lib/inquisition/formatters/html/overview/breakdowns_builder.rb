module Inquisition
  module Formatters
    module Html
      module Overview
        class BreakdownsBuilder < HtmlBuilder
          def initialize(collection)
            super
            @security = []
            @style = []
            @performance = []
            @compatibility = []
            @unused_code = []
            @duplication = []
            sort_by_categories
          end

          def file_name
            'breakdowns.html'
          end

          def sort_by_categories
            @collection.each do |issue|
              case issue # remove line 23 & uncomment 24 when categories will be added
              # case issue.category
              when :security then @security << issue
              when :style then @style << issue
              when :performance then @performance << issue
              when :compatibility then @compatibility << issue
              when :unused_code then @unused_code << issue
              when :duplication then @duplication << issue
              end
            end
          end

          def percentage(category)
            100 / 6 # remove line 36 & uncomment 37 when categories will be added
            # category.count * 100 / @collection.count
          end

          def js_chart
            <<~JS
              <script type="text/javascript">
                var category_percentage = [
                  #{percentage(@security)},
                  #{percentage(@style)},
                  #{percentage(@performance)},
                  #{percentage(@compatibility)},
                  #{percentage(@unused_code)},
                  #{percentage(@duplication)}
                ];
              </script>
            JS
          end
        end
      end
    end
  end
end
