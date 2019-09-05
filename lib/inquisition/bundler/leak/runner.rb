require 'bundler/plumber/scanner'

module Inquisition
  module Bundler
    module Leak
      class Runner < ::Inquisition::Runner
        def call
          ::Bundler::Plumber::Scanner.new.scan do |result|
            @issues << Issue.new(
              severity: :low,
              path: 'Gemfile.lock',
              line: nil,
              message: "#{result.gem.name} #{result.gem.version} - #{result.advisory.title}",
              runner: self
            )
          end
        end
      end
    end
  end
end
