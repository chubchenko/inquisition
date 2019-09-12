module Inquisition
  class Category
    STYLE = :style
    DUPLICATION = :duplication
    UNUSED_CODE = :unused_code
    COMPLEXITY = :complexity
    PERFORMANCE = :performance
    BUG_RISK = :bug_risk
    SECURITY = :security

    NAMES = [SECURITY, BUG_RISK, PERFORMANCE, COMPLEXITY, UNUSED_CODE, DUPLICATION, STYLE].freeze

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
