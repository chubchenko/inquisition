require_relative 'base'

module Inquisition
  module Outputter
    class Doc
      module TPL
        module Tools
          class Workers < Base
            WORKERS = {
              gems: %w[sidekiq resque whenever delayed_job beanstalkd bunny delayed_job_active_record
                       sneakers sucker_punch baskburner que queue_classic],
              exception: 'The gems of this topic not found'
            }.freeze

            def workers
              WORKERS[:gems].each do |gem|
                spec = bundler.specs[gem]
                next unless spec

                spec.each { |gem_specification| yield(create_gem_struct(gem_specification, WORKERS)) }
              end
            end

            def trouble
              gem_exists?(WORKERS[:gems]) ? [] : yield(WORKERS[:exception])
            end
          end
        end
      end
    end
  end
end
