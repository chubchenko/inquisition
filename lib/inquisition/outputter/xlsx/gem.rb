module Inquisition
  module Outputter
    class Xlsx
      class Gem < Row
        attr_writer :version

        def initialize(spec, dependency)
          @spec = spec
          @dependency = dependency
        end

        def to_a
          [
            name,
            homepage,
            version.current.to_s,
            version.latest.to_s,
            version.outdated?,
            env,
            status
          ]
        end

        def name
          @name ||= spec.name
        end

        def homepage
          @homepage ||= spec.homepage
        end

        def env
          @env ||= dependency.groups
        end

        def status; end

        def ==(other)
          hash == other.hash
        end

        alias eql? ==

        def hash
          to_a.hash
        end

        private

        attr_reader :spec, :dependency, :version
      end
    end
  end
end
