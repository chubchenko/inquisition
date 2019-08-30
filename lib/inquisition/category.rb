module Inquisition
  class Category
    NAMES = %i[security style perfomance compatibility unused_code duplication].freeze

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
