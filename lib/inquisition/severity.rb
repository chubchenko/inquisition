module Inquisition
  class Severity
    LOW = :low
    MEDIUM = :medium
    HIGH = :high

    NAMES = [LOW, MEDIUM, HIGH].freeze

    attr_reader :name

    def initialize(name)
      raise ArgumentError, "Unknown severity: #{name}" unless NAMES.include?(name)

      @name = name

      freeze
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
