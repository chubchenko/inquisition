module Inquisition
  module Outputter
    class HTML
      class Issues
        attr_reader :collection

        def initialize(collection)
          @collection = collection
        end

        def produce
          binding
        end
      end
    end
  end
end
