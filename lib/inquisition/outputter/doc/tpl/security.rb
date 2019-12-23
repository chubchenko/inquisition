module Inquisition
  module Outputter
    class Doc
      module TPL
        class Security < Base
          def brakeman
            @brakeman ||= begin
              Template.new('security/brakeman').render(Brakeman.call(@issues))
            end
          end

          def bundler_audit
            @bundler_audit ||= begin
              Template.new('security/bundler_audit').render(BundlerAudit.call(@issues))
            end
          end
        end
      end
    end
  end
end

require_relative 'security/bundler_audit'
require_relative 'security/brakeman'
