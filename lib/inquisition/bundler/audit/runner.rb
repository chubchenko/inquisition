require 'bundler/audit/scanner'
require 'bundler/audit/database'

module Inquisition
  module Bundler
    module Audit
      class Runner < ::Inquisition::Runner
        def call
          ::Bundler::Audit::Database.update!(quiet: true)
          check_errors
        end

        private

        def check_errors
          ::Bundler::Audit::Scanner.new(Rails.root).scan do |error|
            issues << create_error(error.advisory)
          end
          issues
        end

        def create_error(error)
          Inquisition::Issue.new(
            severity: error.criticality || :low,
            line: nil,
            runner: self,
            path: nil,
            message: error.title
          )
        end
      end
    end
  end
end
