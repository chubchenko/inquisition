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
          ::Bundler::Plumber::Scanner.new(Rails.root).scan.map { |warning| issue_for(warning) }
        end

        private

        def issue_for(warning)
          case warning
          when ::Bundler::Plumber::Scanner::UnpatchedGem
            Inquisition::Issue.new(Vulnerability.new(warning.advisory).to_h.merge(runner: self))
          else
            raise ArgumentError, "Unknown type: #{warning.class}"
          end
        end
      end
    end
  end
end
