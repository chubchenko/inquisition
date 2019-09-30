module Inquisition
  module Outputter
    class HTML
      class Overview
        autoload :ByCategory, 'inquisition/outputter/html/overview/by_category'
        autoload :ByExecutor, 'inquisition/outputter/html/overview/by_executor'

        attr_reader :collection

        def initialize(collection)
          @collection = collection
        end

        def produce
          binding
        end

        def by_category
          Template.new('by_category').render(ByCategory.new(collection))
        end

        def by_executor
          Template.new('by_executor').render(ByExecutor.new(collection))
        end
      end
    end
  end
end
