require 'bundler/plumber/scanner'
require 'bundler/plumber/database'

module Inquisition
  module Bundler
    module Leak
      class Runner < ::Inquisition::Runner
        def initialize
          super

          ::Bundler::Plumber::Database.update!(quiet: true)
        end

        def call
          scanner.scan.map do |issue|
            Issue.new(issue_for(issue))
          end
        end

        private

        def scanner
          @scanner ||= ::Bundler::Plumber::Scanner.new(Rails.root)
        end

        def issue_for(issue)
          case issue
          when ::Bundler::Plumber::Scanner::UnpatchedGem
            Vulnerability.new(issue.advisory).to_h.merge(runner: self)
          else
            raise ArgumentError, "Unknown type: #{issue.class}"
          end
        end
      end
    end
  end
end
