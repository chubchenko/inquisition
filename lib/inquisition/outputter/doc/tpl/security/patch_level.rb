module Inquisition
  module Outputter
    class Doc
      module TPL
        class Security
          class PatchLevel
            class Wrapper < SimpleDelegator
              def group
                group_by do |issue|
                  OpenStruct.new(
                    name: issue.context.name,
                    homepage: issue.context.__materialize__&.homepage
                  )
                end
              end
            end

            def self.call(issues)
              new(
                Wrapper.new(Collector.new(issues, ::Inquisition::Bundler::Audit::Runner).call)
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
