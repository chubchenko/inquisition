require 'bundler/audit/scanner'

module Inquisition
  module Bundler
    module Audit
      class Auditor < ::Bundler::Audit::Scanner
        private

        def internal_source?(uri)
          uri = URI(uri.to_s)

          internal_host?(uri.host) if uri.host
        end
      end
    end
  end
end
