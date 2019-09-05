require 'bundler/audit/scanner'
require 'bundler/audit/database'

module Inquisition
  module Bundler
    module Audit
      class Runner < ::Inquisition::Runner
        def initialize
          super

          ::Bundler::Audit::Database.update!(quiet: true)
        end

        def call
          auditor.scan.map do |issue|
            Issue.new(issue_for(issue))
          end
        end

        private

        def auditor
          @auditor ||= ::Bundler::Audit::Scanner.new(Rails.root)
        end

        def issue_for(issue)
          case issue
          when ::Bundler::Audit::Scanner::InsecureSource
            InsecureSource.new(issue.source).to_h.merge(runner: self)
          when ::Bundler::Audit::Scanner::UnpatchedGem
            UnpatchedGem.new(issue.advisory).to_h.merge(runner: self)
          else
            raise ArgumentError, "Unknown type: #{issue.class}"
          end
        end
      end
    end
  end
end
