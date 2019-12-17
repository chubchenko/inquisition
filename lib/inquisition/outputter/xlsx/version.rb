module Inquisition
  module Outputter
    class Xlsx
      class Version
        attr_reader :current, :latest

        def initialize(current, latest)
          @current = ::Gem::Version.new(current)
          @latest = ::Gem::Version.new(latest)
        end

        def outdated?
          current < latest
        end
      end
    end
  end
end
