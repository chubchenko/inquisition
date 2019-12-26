module Inquisition
  module Outputter
    class Doc
      module TPL
        class Stack
          class Collector
            def initialize(known = [], bundler = ::Bundler.load)
              @known = known
              @bundler = bundler
            end

            def call(options = {})
              @known.map do |name|
                specification = bundler.specs.find_by_name_and_platform(name, RUBY_PLATFORM)

                next unless specification

                OpenStruct.new(options.merge(name: specification.name, homepage: specification.homepage))
              end.compact
            end

            private

            attr_reader :bundler
          end
        end
      end
    end
  end
end
