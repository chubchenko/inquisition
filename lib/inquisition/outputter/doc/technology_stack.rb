module Inquisition
  module Outputter
    class Doc
      class TechnologyStack
        EXEPTIONS = {
          monitoring_tools: 'The exception monitoring tool is absent',
          performance_tools: 'The performance services tools is absent',
          default: 'The gems of this topic not found'
        }.freeze

        ABOUT_GEMS = {
          monitoring_tools: 'used as an exception monitoring tool',
          performance_tools: 'userd as an performance monitoring tools'
        }.freeze

        MONITORING_SERVICES = {
          gems: %w[airbrake sentry-raven bugsnag rollbar raygun4ruby],
          description: ABOUT_GEMS[:monitoring_tools],
          exception: EXEPTIONS[:monitoring_tools]
        }.freeze

        MONITORING_PERFORMANCE_SERVICES = {
          gems: %w[newrelic_rpm skylight],
          description: ABOUT_GEMS[:performance_tools],
          exception: EXEPTIONS[:performance_tools]
        }.freeze

        WORKERS_WITH_JOBS = {
          gems: %w[sidekiq resque whenever delayed_job beanstalkd bunny delayed_job_active_record
                   sneakers sucker_punch baskburner que queue_classic],
          exception: EXEPTIONS[:default]
        }.freeze
      end
    end
  end
end
