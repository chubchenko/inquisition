module Inquisition
  module Outputter
    class Doc
      module Templates
        class BaseTemplate
          attr_reader :issues

          def initialize(issues = [])
            @issues = issues
          end

          def produce
            binding
          end

          def collect_issues(runner_name)
            issues&.map { |issue| issue if runner_issue_exists?(issue, runner_name) }&.compact
          end

          def take_issues_by_difficulty(issues, difficulty)
            issues&.map { |issue| issue if issue.severity.name == difficulty }&.compact
          end

          def gem_exists?(gem)
            Gem.loaded_specs.key?(gem)
          end

          private

          def runner_issue_exists?(issue, runner_name)
            Inquisition::Badge.for(issue.runner.class.name).name == runner_name
          end
        end
      end
    end
  end
end
