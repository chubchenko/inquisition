module Inquisition
  module Outputter
    class Doc
      module TPL
        class Security
          class Brakeman < SimpleDelegator
            def self.call(issues)
              new(Collection.new(issues))
            end

            def produce
              binding
            end

            class Collection
              def initialize(issues)
                @issues = issues.select do |issue|
                  issue.runner.is_a?(::Inquisition::Brakeman::Runner)
                end
              end

              def tally
                issues.group_by(&:context).each { |type, collection| yield(type, collection.count) }
              end

              def count
                @count ||= issues.count
              end

              def high
                @high ||= by_severity.fetch(:high) { [].freeze }
              end

              private

              attr_reader :issues

              def by_severity
                @by_severity ||= begin
                  issues.group_by { |issue| issue.severity.name }
                end
              end
            end
          end
        end
      end
    end
  end
end
