require_relative 'tools/monitoring'
require_relative 'tools/workers'

module Inquisition
  module Outputter
    class Doc
      module TPL
        class Stack
          def produce
            binding
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

          def monitoring
            @monitoring ||= begin
              Template.new('stack/monitoring').render(Tools::Monitoring.new)
            end
          end

          def workers
            @workers ||= begin
              Template.new('stack/workers').render(Tools::Workers.new)
            end
          end
        end
      end
    end
  end
end
