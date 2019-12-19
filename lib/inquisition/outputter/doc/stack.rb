module Inquisition
  module Outputter
    class Doc
      class Stack
        def technology_stack
          @technology_stack ||= begin
            Template.new('technology_stack').render(Stack::TechnologyScan.new)
          end
        end
      end
    end
  end
end
