module Inquisition
  module Outputter
    class Doc
      module TPL
        class Security
          class BottlenecksDetection
            class LolDba
              def self.call(issues)
                new(Collector.new(issues, ::Inquisition::LolDba::Runner).call)
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
end
