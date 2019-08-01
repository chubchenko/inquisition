module Inquisition
  class Severity
    NAMES = %i[high medium low].freeze

    attr_reader :name

    def initialize(name)
      raise ArgumentError, "Unknown severity: #{name}" unless NAMES.include?(name)

      @name = name
    end

    def ==(other)
      name == other.name
    end

    alias eql? ==

    def hash
      name.hash
    end
  end
end
