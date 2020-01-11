module Inquisition
  module Outputter
    class Doc
      module TPL
        class Bottleneck
          class ActiveRecordDoctor
            def self.call(issues)
              new(Security::Collector.new(issues, ::Inquisition::ActiveRecordDoctor::Runner).call)
            end

            attr_reader :collection

            def initialize(collection)
              @collection = collection
            end

            def produce
              binding
            end
          end
        end
      end
    end
  end
end
