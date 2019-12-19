module Inquisition
  module Outputter
    class Doc
      module Filters
        class Base
          def initialize(issues, collection_class)
            @collection = collection_class.new(issues)
          end

          def produce
            binding
          end

          def issues
            @collection
          end
        end
      end
    end
  end
end
