module Inquisition
  module Outputter
    module Documentation
      class DocViewHelper
        ERROR_FIND_GEMS_MESSAGE = 'There is no one gem'.freeze
        MONITORING_SERVICES = %w[airbrake sentry-raven bugsnag rollbar raygun].freeze
        WORKERS_WITH_JOBS = %w[sidekiq resque whenever delayed_job beanstalkd bunny delayed_job_active_record
                               sneakers sucker_punch baskburner que queue_classic].freeze

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

        private

        def gem_exists?(gem)
          Gem.loaded_specs.key?(gem)
        end
      end
    end
  end
end
