require 'bundler/plumber/scanner'

module Inquisition
  module Bundler
    module Leak
      class Runner < ::Inquisition::Runner
        def call
          ::Bundler::Plumber::Scanner.new(Rails.root.to_s).scan.map { |warning| issue_for(warning.advisory) }
        end

        def issue_for(advisory)
          Inquisition::Issue.new(Issue.new(advisory).to_h.merge(runner: self))
        end
      end
    end
  end
end
