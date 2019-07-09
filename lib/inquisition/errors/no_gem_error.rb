module Inquisition
  module Errors
    class NoGemError < BaseError
      def initialize(name)
        super("Gem #{name} not found")
      end
    end
  end
end
