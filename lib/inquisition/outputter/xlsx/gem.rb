module Inquisition
  module Outputter
    class Xlsx
      class Gem < Row
        attr_reader :version

        def initialize(data, spec, dep)
          @data = data
          @version = Version.new(
            data.version.to_s,
            spec.max_by(&:version).version.to_s
          )
          @dep = dep
        end

        def to_a
          [
            name,
            homepage,
            version.current,
            version.latest,
            version.outdated?,
            env,
            status
          ]
        end

        def name
          @name ||= data.name
        end

        def homepage
          data.homepage
        end

        def env
          @dep.groups
        end

        def status; end

        private

        attr_reader :data
      end
    end
  end
end
