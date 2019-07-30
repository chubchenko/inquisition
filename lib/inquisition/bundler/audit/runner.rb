require 'bundler/audit/scanner'
require 'bundler/audit/database'

module Inquisition
  module Bundler
    module Audit
      class Runner < ::Inquisition::Runner
        attr_reader :issues

        def call
          ::Bundler::Audit::Database.update!
          check_errors
        end

        private

        def check_errors
          @issues = []
          ::Bundler::Audit::Scanner.new.scan do |error|
            issues << create_error(error)
          end
          issues
        end

        def create_error(error)
          Inquisition::Issue.new(
            level: error.advisory.criticality || Inquisition::Issue::LEVELS[:low],
            line: '',
            runner: self,
            file: error.advisory.path,
            message: error.advisory.title
          )
        end
      end
    end
  end
end
