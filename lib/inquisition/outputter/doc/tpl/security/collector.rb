require_relative 'collector'

module Inquisition
  module Outputter
    class Doc
      module TPL
        class Security
          Collection = Class.new(Array) do
            ::Inquisition::Severity::NAMES.each do |name|
              define_method(name) do
                memoizer = instance_variable_get("@#{name}")
                return memoizer if memoizer
                instance_variable_set("@#{name}", by_severity.fetch(name) { [].freeze })
              end
            end

            private

            def by_severity
              @by_severity ||= begin
                group_by { |issue| issue.severity.name }
              end
            end
          end

          class Collector
            def initialize(issues, klass)
              @collection = Collection.new
              @issues = issues
              @klass = klass
            end

            def call
              @collection.push(*@issues.select do |issue|
                issue.runner.is_a?(@klass)
              end)

              @collection
            end
          end
        end
      end
    end
  end
end
