require_relative 'technology_stack'
require_relative 'gem_details'

module Inquisition
  module Outputter
    class Doc
      class ViewHelper
        attr_reader :issues

        def initialize(issues)
          @issues = issues
        end

        def workers_with_jobs
          define_exists_gems(TechnologyStack::WORKERS_WITH_JOBS)
        end

        def monitoring_tools
          define_exists_gems(TechnologyStack::MONITORING_SERVICES).push(*performance_tools)
        end

        def produce
          binding
        end

        def date_today
          "#{Date.today.day.ordinalize} #{Date::MONTHNAMES[Date.today.month]} #{Date.today.year}"
        end

        def collect_issues(runner_name)
          issues&.map { |issue| issue if runner_issue_exists?(issue, runner_name) }&.compact
        end

        def group_brakeman_issues_by_warnings
          collect_issues('brakeman')&.group_by { |issue| issue.aditional_data.warning_type }
        end

        def group_bundler_audit_issues
          collect_issues('bundler_audit')&.group_by do |issue|
            gem = GemDetails.new(issue.aditional_data.gem.name)
            { name: gem.name, link: gem.link }
          end
        end

        def take_issues_by_difficulty(issues, difficulty)
          issues&.map { |issue| issue if issue.severity.name == difficulty }&.compact
        end

        private

        def runner_issue_exists?(issue, runner_name)
          Inquisition::Badge.for(issue.runner.class.name).name == runner_name
        end

        def performance_tools
          define_exists_gems(TechnologyStack::MONITORING_PERFORMANCE_SERVICES)
        end

        def define_exists_gems(data)
          exist_gems = data[:gems].map { |gem| GemDetails.new(gem, data[:description]) if gem_exists?(gem) }
          exist_gems.any? ? exist_gems.compact : [{ exception: data[:exception] }]
        end

        def gem_exists?(gem)
          Gem.loaded_specs.key?(gem)
        end
      end
    end
  end
end
