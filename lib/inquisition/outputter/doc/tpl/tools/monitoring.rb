require_relative 'base'

module Inquisition
  module Outputter
    class Doc
      module TPL
        module Tools
          class Monitoring < Base
            MONITORING_SERVICES = {
              gems: %w[airbrake sentry-raven bugsnag rollbar raygun4ruby],
              description: 'Used as an exception monitoring tool',
              exception: 'Exception tools is absent'
            }.freeze

            MONITORING_PERFORMANCE_SERVICES = {
              gems: %w[newrelic_rpm skylight],
              description: 'Used as an performance monitoring tools',
              exception: 'Performance tools is absent'
            }.freeze

            def monitoring
              services.each do |service|
                service[:gems].each do |gem|
                  spec = bundler.specs[gem]
                  next unless spec

                  spec.each { |gem_specification| yield(create_gem_struct(gem_specification, service)) }
                end
              end
            end

            def trouble
              services.map { |service| gem_exists?(service[:gems]) ? [] : service[:exception] }.flatten
            end

            private

            def services
              [MONITORING_SERVICES, MONITORING_PERFORMANCE_SERVICES]
            end
          end
        end
      end
    end
  end
end
