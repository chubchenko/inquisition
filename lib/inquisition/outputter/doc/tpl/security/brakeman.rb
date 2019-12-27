module Inquisition
  module Outputter
    class Doc
      module TPL
        class Security
          class Brakeman
            class Wrapper < SimpleDelegator
              def tally
                group_by(&:context).each do |type, collection|
                  yield(type, collection.count)
                end
              end
            end

            def self.call(issues)
              new(
                Wrapper.new(Collector.new(issues, ::Inquisition::Brakeman::Runner).call)
              )
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
