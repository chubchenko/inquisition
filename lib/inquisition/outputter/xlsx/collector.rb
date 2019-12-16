module Inquisition
  module Outputter
    class Xlsx
      class Collector
        def initialize
          @bundler = ::Bundler.load
        end

        def call
          bundler.specs
                 .select(&Dependency.new(bundler).method(:match?))
                 .map(&Converter.new(bundler, definition).method(:call))
        end

        private

        attr_reader :bundler

        def definition
          @definition ||= begin
            ::Bundler.definition(true).tap(&:resolve_remotely!)
          end
        end

        class Dependency
          def initialize(bundler)
            @bundler = bundler
          end

          def match?(spec)
            @bundler.dependencies.any? do |dependency|
              dependency.name == spec.name
            end
          end
        end

        class Converter
          def initialize(bundler, definition)
            @bundler = bundler
            @definition = definition
          end

          def call(spec)
            collection = @definition.index[spec.name]

            dependency = find_dependency(spec)

            Gem.new(spec, collection, dependency)
          end

          private

          def find_dependency(spec)
            @bundler.dependencies.detect do |dependency|
              dependency.name == spec.name
            end
          end
        end
      end
    end
  end
end
