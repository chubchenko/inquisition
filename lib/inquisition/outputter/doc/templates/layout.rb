require_relative 'home'
require_relative 'technology_stack_scan'

module Inquisition
  module Outputter
    class Doc
      module Templates
        class Layout
          def produce
            binding
          end

          def home
            @home ||= begin
              Template.new('home').render(Home.new)
            end
          end

          def technology_stack
            @technology_stack ||= begin
              Template.new('technology_stack').render(TechnologyStackScan.new)
            end
          end
        end
      end
    end
  end
end
