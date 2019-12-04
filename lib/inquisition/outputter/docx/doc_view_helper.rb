module Inquisition
  module Outputter
    module Docx
      class DocViewHelper
        ERROR_FIND_GEMS_MESSAGE = 'There is no one gem'.freeze
        MONITORING_SERVICES = %w[airbrake sentry-raven bugsnag rollbar raygun].freeze
        WORKERS_WITH_JOBS = %w[sidekiq resque whenever delayed_job beanstalkd bunny delayed_job_active_record
                               sneakers sucker_punch baskburner que queue_classic].freeze

        attr_reader :issues

        def initialize(issues)
          @issues = issues
        end

        def define_exists_gems(gems)
          exist_gems = gems.map { |name_gem| name_gem if gem_exists?(name_gem) }
          exist_gems.any? ? exist_gems.compact : [ERROR_FIND_GEMS_MESSAGE]
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

        def group_issues_by_column(issues, issue_type)
          issues&.group_by(&issue_type)
        end

        def take_issues_by_difficulty(issues, difficulty)
          issues&.map { |issue| issue if issue.severity.name == difficulty }&.compact
        end

        private

        def runner_issue_exists?(issue, runner_name)
          Inquisition::Badge.for(issue.runner.class.name).name == runner_name
        end

        def gem_exists?(gem)
          Gem.loaded_specs.key?(gem)
        end
      end
    end
  end
end
