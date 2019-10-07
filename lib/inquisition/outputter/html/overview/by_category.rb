module Inquisition
  module Outputter
    class HTML
      class Overview
        class ByCategory
          def initialize(collection)
            @collection = collection
            @grouped = grouped
          end

          def breakdown
            Category::NAMES.map do |name|
              to_percentage(@grouped[Category.new(name)])
            end
          end

          def produce
            binding
          end

          private

          def grouped
            grouped = Hash.new([])
            grouped.update(@collection.group_by(&:category))
            grouped
          end

          def to_percentage(collection)
            (collection.count * 100.0 / @collection.count).round(2)
          end
        end
      end
    end
  end
end
