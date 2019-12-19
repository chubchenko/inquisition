require_relative 'base'
require_relative '../filters/base'
require_relative '../filters/brakeman/collection'
require_relative '../filters/bundler_audit/collection'

module Inquisition
  module Outputter
    class Doc
      module TPL
        class Security < Base
          def brakeman
            @brakeman ||= begin
              Template.new('brakeman').render(Filters::Base.new(@issues, Filters::Brakeman::Collection))
            end
          end

          def bundler_audit
            @bundler_audit ||= begin
              Template.new('bundler_audit').render(Filters::Base.new(@issues, Filters::BundlerAudit::Collection))
            end
          end
        end
      end
    end
  end
end
