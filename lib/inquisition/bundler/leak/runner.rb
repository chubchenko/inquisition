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
          ::Bundler::Plumber::Scanner.new(Rails.root).scan.map { |warning| issue_for(warning.advisory) }
        end

        private

        def issue_for(advisory)
          Inquisition::Issue.new(Vulnerability.new(advisory).to_h.merge(runner: self))
        end
      end
    end
  end
end
