module Inquisition
  module Outputter
    class Doc
      module TPL
        class Quality
          class Rubycritic
            class Wrapper < SimpleDelegator
              def group
                group_by(&:severity).each do |severity, collection|
                  yield(severity.name.to_s.capitalize, collection)
                end
              end
            end

            def self.call(issues)
              new(
                Wrapper.new(Security::Collector.new(issues, ::Inquisition::Rubycritic::Runner).call)
              )
            end

            MIN_SCORE = 0
            attr_reader :collection

            def initialize(collection)
              @collection = collection
            end

            def produce
              binding
            end

            def types(issues)
              issues.group_by(&:context).each do |warning, collection|
                yield(warning, collection.count)
              end
            end

            def score
              collection&.first&.runner&.common_score || MIN_SCORE
            end

            def link
              Stack::Collector.new(['rubycritic']).call.first.homepage
            end
          end
        end
      end
    end
  end
end
