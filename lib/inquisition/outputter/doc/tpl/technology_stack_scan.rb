require_relative '../stack'
require_relative '../gem_details'
require_relative 'base'
require_relative '../stack/technology_scan'

module Inquisition
  module Outputter
    class Doc
      module TPL
        class TechnologyStackScan < Base
          def workers_with_jobs
            define_exists_gems(Stack::TechnologyScan::WORKERS_WITH_JOBS)
          end

          def monitoring_tools
            define_exists_gems(Stack::TechnologyScan::MONITORING_SERVICES).push(*performance_tools)
          end

          def database_adapter
            Rails.configuration.database_configuration['default']['adapter']
          end

          def ruby_version
            RUBY_VERSION
          end

          def ruby_on_rails_version
            Rails.version
          end

          private

          def performance_tools
            define_exists_gems(Stack::TechnologyScan::MONITORING_PERFORMANCE_SERVICES)
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
end
