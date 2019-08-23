module Inquisition
  class Category
    SECURITY = :security
    STYLE = :style
    PERFOMANCE = :perfomance
    COMPLEXITY = :complexity
    UNUSED_CODE = :unused_code
    DUPLICATION = :duplication
    BUG_RISK = :bug_risk

    NAMES = [SECURITY, STYLE, PERFOMANCE, COMPLEXITY, UNUSED_CODE, DUPLICATION, BUG_RISK].freeze

    attr_reader :name

    def initialize(name)
      raise ArgumentError, "Unknown category: #{name}" unless NAMES.include?(name)

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
