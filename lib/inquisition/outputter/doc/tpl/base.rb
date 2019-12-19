module Inquisition
  module Outputter
    class Doc
      module TPL
        class Base
          attr_reader :issues, :filter

          def initialize(issues = [])
            @issues = issues
          end

          def produce
            binding
          end
        end
      end
    end
  end
end
