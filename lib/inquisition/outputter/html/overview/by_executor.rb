module Inquisition
  module Outputter
    class HTML
      class Overview
        class ByExecutor
          def initialize(collection)
            @collection = collection
            @grouped = grouped
          end

          def to_percentage(collection)
            (collection.count * 100.0 / @collection.count).round(2)
          end

          def produce
            binding
          end

          private

          def grouped
            grouped = Hash.new([])
            grouped.update(@collection.group_by { |item| item.runner.class })
            grouped
          end
        end
      end
    end
  end
end
