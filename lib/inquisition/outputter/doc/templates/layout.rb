require_relative 'home'
require_relative 'technology_stack_scan'
require_relative 'brakeman'

module Inquisition
  module Outputter
    class Doc
      module Templates
        class Layout
          attr_reader :issues

          def initialize(issues)
            @issues = issues
          end

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

          def brakeman
            @brakeman ||= begin
              Template.new('brakeman').render(Brakeman.new(issues))
            end
          end
        end
      end
    end
  end
end
