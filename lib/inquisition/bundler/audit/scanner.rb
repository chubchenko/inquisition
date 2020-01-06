require 'bundler/audit/scanner'

module Inquisition
  module Bundler
    module Audit
      class Scanner < ::Bundler::Audit::Scanner
        def internal_source?(uri)
          host = URI(uri.to_s).host

          internal_host?(host) if host
        end
      end
    end
  end
end
