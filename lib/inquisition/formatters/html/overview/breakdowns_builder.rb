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
              # case issue.category
              case issue
              when :security then @security << issue
              when :style then @style << issue
              when :performance then @performance << issue
              when :compatibility then @compatibility << issue
              when :unused_code then @unused_code << issue
              when :duplication then @duplication << issue
              end
            end
          end

          def category_percentage(category)
            category.count * 100 / @collection.count
          end

          def js_chart
            <<~JS
              <script type="text/javascript">
                var ctx = document.getElementById("myPieChart");
                new Chart(ctx, {
                  type: 'doughnut',
                  data: {
                    // labels: [
                    //   "Security - #{@security.count}",
                    //   "Style - #{@style.count}",
                    //   "Performance - #{@performance.count}",
                    //   "Compatibility - #{@compatibility.count}",
                    //   "Unused Code - #{@unused_code.count}",
                    //   "Duplication - #{@duplication.count}"
                    // ],
                    labels: ["Security", "Style", "Performance", "Compatibility", "Unused Code", "Duplication"],
                    datasets: [{
                      // data: [
                      //   category_percentage(@security),
                      //   category_percentage(@style),
                      //   category_percentage(@performance),
                      //   category_percentage(@compatibility),
                      //   category_percentage(@unused_code),
                      //   category_percentage(@duplication)
                      // ],
                      data: [80, 7, 6, 3, 2, 2],
                      backgroundColor: ['#e74a3b', '#1cc88a', '#36b9cc', '#f6c23e', '#4e73df', '#858796'],
                      hoverBackgroundColor: ['#B03524', '#3C835F', '#40828F', '#D6A339', '#234EB7', '#5A5C68'],
                      hoverBorderColor: "rgba(234, 236, 244, 1)",
                    }],
                  },
                  options: {
                    maintainAspectRatio: false,
                    tooltips: {
                      backgroundColor: "rgb(255,255,255)",
                      bodyFontColor: "#858796",
                      borderColor: '#dddfeb',
                      borderWidth: 1,
                      xPadding: 15,
                      yPadding: 15,
                      displayColors: false,
                      caretPadding: 10,
                    },
                    legend: {
                      display: false
                    },
                    cutoutPercentage: 80,
                  },
                });
              </script>
            JS
          end
        end
      end
    end
  end
end
