require 'bundler/audit/cli'
require 'bundler/audit/scanner'

module Inquisition
  module Bundler
    module Audit
      class Runner < ::Inquisition::Runner
        RUNNER_NAME = 'Bundler-audit'.freeze
        LOW_LEVEL = :low
        attr_reader :issues

        def call
          ::Bundler::Audit::CLI.start [:update]
          check_errors
        end

        private

        def check_errors
          @issues = []
          ::Bundler::Audit::Scanner.new.scan { |error| issues << create_error(error) }
          issues
        end

        def create_error(error)
          Inquisition::Issue.new(
            level: error.advisory.criticality || LOW_LEVEL,
            line: '',
            runner: RUNNER_NAME,
            file: error.advisory.path,
            message: error.advisory.title
          )
        end
      end
    end
  end
end
