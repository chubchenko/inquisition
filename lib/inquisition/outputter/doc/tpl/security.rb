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
            @bundler_audit ||= begin
              Template.new('security/patch_level').render(PatchLevel.call(@issues))
            end
          end
        end
      end
    end
  end
end

require_relative 'security/collector'
require_relative 'security/brakeman'
require_relative 'security/patch_level'
