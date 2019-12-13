require_relative 'home'
require_relative 'technology_stack_scan'
require_relative 'brakeman'
require_relative 'base_template'
require_relative 'patch_level_verification'
require_relative 'bottlenecks_detection'

module Inquisition
  module Outputter
    class Doc
      module Templates
        class Layout < BaseTemplate
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

          def patch_level_verification
            @patch_level_verification ||= begin
              Template.new('patch_level_verification').render(PatchLevelVerification.new(issues))
            end
          end

          def bottlenecks_detection
            @bottlenecks_detection ||= begin
              Template.new('bottlenecks_detection').render(BottlenecksDetection.new(issues))
            end
          end
        end
      end
    end
  end
end
