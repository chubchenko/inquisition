module Inquisition
  module Outputter
    class Doc
      module TPL
        class Stack
          NoExceptionPkg = Class.new(StandardError) do
            def initialize
              super(
                'Exception management system is absent'
              )
            end
          end

          class Exception
            KNOWN = %w[
              airbrake
              rollbar
              bugsnag
              sentry-raven
            ].freeze

            DESCRIPTION = 'Used as an exception management system'.freeze

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
              NoExceptionPkg.new
            end
          end
        end
      end
    end
  end
end
