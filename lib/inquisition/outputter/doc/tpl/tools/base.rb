module Inquisition
  module Outputter
    class Doc
      module TPL
        module Tools
          class Base
            def produce
              binding
            end

            protected

            def gem_exists?(gems)
              gems.any? { |gem| Gem.loaded_specs.key?(gem) }
            end

            def bundler
              @bundler ||= ::Bundler.load
            end

            def create_gem_struct(gem, service)
              OpenStruct.new(
                name: gem.name,
                homepage: gem.homepage || '',
                description: service[:description] || ''
              )
            end
          end
        end
      end
    end
  end
end
