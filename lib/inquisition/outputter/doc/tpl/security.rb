module Inquisition
  module Outputter
    class Doc
      module TPL
        class Security < Base
          def initialize(issues)
            @issues = issues
          end

          def brakeman
            @brakeman ||= begin
              Template.new('security/brakeman').render(Brakeman.call(@issues))
            end
          end

          def patch_level
            @patch_level ||= begin
              Template.new('security/patch_level').render(PatchLevel.call(@issues))
            end
          end

          def bottlenecks_detection
            @bottlenecks_detection ||= begin
              Template.new('security/bottlenecks_detection').render(TPL::BottlenecksDetection.new(@issues))
            end
          end
        end
      end
    end
  end
end

require_relative 'bottlenecks_detection'
require_relative 'security/collector'
require_relative 'security/brakeman'
require_relative 'security/patch_level'
