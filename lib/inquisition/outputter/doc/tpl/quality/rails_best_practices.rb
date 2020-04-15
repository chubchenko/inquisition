module Inquisition
  module Outputter
    class Doc
      module TPL
        class Quality
          class RailsBestPractices
            class Wrapper < SimpleDelegator
              def group
                group_by(&:severity).each do |severity, collection|
                  yield(severity.name.to_s.capitalize, collection)
                end
              end
            end

            def self.call(issues)
              new(
                Wrapper.new(Security::Collector.new(issues, ::Inquisition::RailsBestPractices::Runner).call)
              )
            end

            def produce
              binding
            end

            def types(issues)
              issues.group_by(&:message).each do |warning, collection|
                yield(warning, collection.count)
              end
            end

            attr_reader :collection

            def initialize(collection)
              @collection = collection
            end

            def link
              @link ||= Stack::Collector.new(['rails_best_practices']).call.first.homepage
            end
          end
        end
      end
    end
  end
end
