module Inquisition
  module Rubycritic
    class Smell
      def initialize(smell, location)
        @smell = smell
        @location = location
      end

      def to_h
        {
          path: location.pathname.relative_path_from(Rails.root).to_s,
          line: location.line,
          severity: Inquisition::Severity::LOW,
          message: "#{smell.context} #{smell.message}",
          context: smell.type
        }
      end

      private

      attr_reader :smell, :location
    end
  end
end
