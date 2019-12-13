require_relative '../technology_stack'
require_relative '../gem_details'
require_relative 'base_template'

module Inquisition
  module Outputter
    class Doc
      module Templates
        class TechnologyStackScan < BaseTemplate
          def workers_with_jobs
            define_exists_gems(TechnologyStack::WORKERS_WITH_JOBS)
          end

          def monitoring_tools
            define_exists_gems(TechnologyStack::MONITORING_SERVICES).push(*performance_tools)
          end

          def database_adapter
            Rails.configuration.database_configuration['default']['adapter']
          end

          private

          def performance_tools
            define_exists_gems(TechnologyStack::MONITORING_PERFORMANCE_SERVICES)
          end

          def define_exists_gems(data)
            exist_gems = data[:gems].map { |gem| GemDetails.new(gem, data[:description]) if gem_exists?(gem) }
            exist_gems.any? ? exist_gems.compact : [{ exception: data[:exception] }]
          end
        end
      end
    end
  end
end
