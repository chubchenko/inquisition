require 'bundler/plumber/scanner'

module Inquisition
  module Bundler
    module Leak
      class Runner < ::Inquisition::Runner
        def call
          ::Bundler::Plumber::Scanner.new.scan { |warning| issue_for(warning) }
          @issues
        end

        def issue_for(warning)
          @issues << Issue.new(Vulnerability.new(warning).to_h.merge(runner: self))
        end
      end
    end
  end
end
