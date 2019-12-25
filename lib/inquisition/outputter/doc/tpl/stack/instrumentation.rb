module Inquisition
  module Outputter
    class Doc
      module TPL
        class Stack
          NoInstrumentationPkg = Class.new(StandardError) do
            def initialize
              super(
                'Performance management system is absent'
              )
            end
          end

          class Instrumentation
            KNOWN = %w[
              newrelic_rpm skylight
            ].freeze

            DESCRIPTION = 'Used as an performance management system'.freeze

            def produce
              binding
            end

            def collection
              @collection ||= Collector.new(KNOWN).call(description: DESCRIPTION)
            end

            def empty?
              collection.empty?
            end

            def trouble
              NoInstrumentationPkg.new
            end
          end
        end
      end
    end
  end
end
