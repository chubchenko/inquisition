module Inquisition
  class Category
    SECURITY = :security
    STYLE = :style
    PERFOMANCE = :perfomance
    COMPATIBILITY = :compatibility
    UNUSED_CODE = :unused_code
    DUPLICATION = :duplication

    NAMES = [SECURITY, STYLE, PERFOMANCE, COMPATIBILITY, UNUSED_CODE, DUPLICATION].freeze

    attr_reader :name

    def initialize(name)
      raise ArgumentError, "Unknown category: #{name}" unless NAMES.include?(name)

      @name = name
    end

    def ==(other)
      name == other.name
    end

    alias eql? ==
  end
end
