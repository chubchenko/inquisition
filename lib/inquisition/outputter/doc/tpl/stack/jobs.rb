module Inquisition
  module Outputter
    class Doc
      module TPL
        class Stack
          class Jobs
            KNOWN = %w[
              resque
              sidekiq
              whenever
              delayed_job
              sucker_punch
            ].freeze

            def produce
              binding
            end

            def collection
              @collection ||= Collector.new(KNOWN).call
            end
          end
        end
      end
    end
  end
end
